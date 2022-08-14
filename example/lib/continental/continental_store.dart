import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:deact_bootstrap/server_renderer.dart';
import 'package:bootstrap_dart_example/continental/continental_command.dart';
import 'package:bootstrap_dart_example/database.dart';
import 'package:collection/collection.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:mobx/mobx.dart';
import 'package:idb_shim/idb.dart' as idb;

import 'package:bootstrap_dart_example/mobx_helpers.dart';

class ContinentalData {
  final String key;
  final String playerId;
  final ContinentalStep step;
  final Card? topCard;
  final int? currentPlayerIndex;
  final String? currentPlayer;
  final List<Map<String, int>> counts;
  final List<String> players;
  final List<Card> cards;
  final List<List<Card>> tableCards;
  final Map<String, List<List<Card>>> otherTableCards;
  final bool canPunish;
  final ContinentalPlayStep playerStep;

  ContinentalData({
    required this.key,
    required this.playerId,
    required this.step,
    required this.topCard,
    required this.currentPlayerIndex,
    required this.currentPlayer,
    required this.counts,
    required this.players,
    required this.cards,
    required this.tableCards,
    required this.otherTableCards,
    required this.canPunish,
    required this.playerStep,
  });
}

class ContinentalStore extends TreeStore<ContinentalComm, String> {
  ContinentalStore({required this.key, int? randomSeed})
      : randomSeed = randomSeed ?? Random.secure().nextInt(1e9.toInt()) {
    setUp();
    _random = Random(randomSeed);
    _db.complete(_createIDB());
  }
  int randomSeed;
  late Random _random;
  final String key;
  final Completer<idb.Database?> _db = Completer();
  bool _loading = false;
  Future? _txFuture;
  Future<idb.Database?> db() async {
    if (_txFuture != null) return _txFuture!.then((value) => db());
    return _db.future;
  }

  void setUp() {
    on<ContinentalCommStart>((p) => _start());
    on<ContinentalCommAddPlayer>((p) => _addPlayer(p.playerId));
    on<ContinentalCommComer>((p) => _comer(fromDropped: p.fromDropped));
    on<ContinentalCommCastigarse>((p) => _castigarse(p.playerId));
    on<ContinentalCommBajar>((p) => _bajar(p.cardSet));
  }

  @override
  void onSuccess(ContinentalComm command) async {
    if (kIsWeb && !_loading && getIdbFactory() != null) {
      final tx =
          (await db())!.transaction(ClientDB.commandsTableName, 'readwrite');
      final objStore = tx.objectStore(ClientDB.commandsTableName);
      final _comm = jsonDecode(
        jsonEncode(command.toJson()..['storeKey'] = key),
      );
      objStore.add(_comm);
      _txFuture = tx.completed;
      await tx.completed;
      _txFuture = null;
    }
  }

  Future<idb.Database?> _createIDB() async {
    if (!kIsWeb) return null;
    final db = await ClientDB.get();
    final tx = db!.transaction(ClientDB.commandsTableName, 'readwrite');
    final objStore = tx.objectStore(ClientDB.commandsTableName);
    final values = await objStore.getAll(null);
    print('_createIDB $values');

    if (values.isNotEmpty) {
      runInAction(() {
        _loading = true;
        randomSeed = (values.first as Map)['seed'] as int;
        _random = Random(randomSeed);

        for (final v in values.skip(1)) {
          final comm = ContinentalComm.fromJson(castMap(v as Map));
          consume(comm);
        }
        _loading = false;
      });
    } else {
      await objStore.add({'seed': randomSeed, 'storeKey': key});
    }
    await tx.completed;
    return db;
  }

  late final step = obs(ContinentalStep.tt);
  late final playerStep = obs(ContinentalPlayStep.eating);
  late final topCard = obs<Card?>(null);
  late final currentPlayerIndex = obs<int?>(null);

  late final currentPlayer = Computed<ContinentalPlayer?>(
    () => currentPlayerIndex.value == null
        ? null
        : players[currentPlayerIndex.value!],
  );

  late final canPunish = Computed<bool>(
    () =>
        topCard.value != null &&
        playerStep.value == ContinentalPlayStep.dropping,
  );

  final counts = ObservableList<Map<String, int>>();
  final players = ObservableList<ContinentalPlayer>();
  final List<Card> allCards = [];
  int currentCard = 0;

  // List<int> extractedCards = [];
  // Map<int, Set<CardType>> extractedCardType = {};

  ContinentalPlayer? playerById(String playerId) =>
      players.firstWhereOrNull((element) => element.id == playerId);

  void _addPlayer(String playerId) {
    if (playerById(playerId) == null) {
      players.add(ContinentalPlayer(id: playerId));
    } else {
      throw 'Player "$playerId" already in game.';
    }
  }

  void _start() {
    if (currentPlayerIndex.value != null) return;
    _resetCards();
  }

  void _castigarse(String playerId) {
    final _card = topCard.value;
    final player = playerById(playerId);
    if (_card == null ||
        player == null ||
        currentPlayer.value?.id == playerId ||
        playerStep.value != ContinentalPlayStep.dropping) {
      throw 'Wrong state for punishing.';
    }
    topCard.value = null;
    final newCard = _selectNewCard();
    player.cards.add(_card);
    player.cards.add(newCard);
  }

  void _comer({required bool fromDropped}) {
    final player = currentPlayer.value;
    if (player == null || playerStep.value != ContinentalPlayStep.eating) {
      throw 'Wrong state for eating.';
    }

    final Card card;
    if (!fromDropped) {
      card = _selectNewCard();
    } else {
      final _card = topCard.value;
      if (_card == null) throw 'No available top card.';
      card = _card;
      topCard.value = null;
    }
    player.cards.add(card);
    playerStep.value = ContinentalPlayStep.dropping;
  }

  void _bajar(CardSet cardSet) {
    final player = currentPlayer.value;
    if (player == null) throw 'Not playing.';
    if (playerStep.value != ContinentalPlayStep.dropping) {
      throw 'Wrong state for dropping.';
    }

    if (player.tableCards.isEmpty && cardSet.external.isNotEmpty) {
      throw 'Cannot drop external cards.';
    }
    if (!cardSet.validate()) throw 'Card set invalid.';
    if (player.tableCards.isEmpty &&
        (cardSet.threesomes.isNotEmpty || cardSet.stairs.isNotEmpty)) {
      if (step.value.threesomes != cardSet.threesomes.length) {
        throw 'Should be ${step.value.threesomes} threesomes.';
      }
      if (step.value.stairs != cardSet.stairs.length) {
        throw 'Should be ${step.value.stairs} stairs.';
      }
    }

    // extract from player's cards
    final copyCards = player.cards.sublist(0);
    for (final c in cardSet.allCards()) {
      if (!copyCards.remove(c)) throw 'Card $c not in hand.';
    }

    final updates = <List<Card>, List<ExternalCard>>{};
    for (final c in cardSet.external) {
      final other = playerById(c.playerId);
      if (other == null ||
          c.tableCardsId < 0 ||
          c.tableCardsId > other.tableCards.length) {
        throw 'Wrong external card id ${c.playerId} ${c.tableCardsId}.';
      }
      final tableCards = other.tableCards[c.tableCardsId];
      if (c.position < 0 || c.position > tableCards.length) {
        throw 'Wrong external card id ${c.playerId} ${c.tableCardsId} ${c.position}.';
      }
      updates.putIfAbsent(tableCards, () => []).add(c);
    }
    // if (updates.values
    //     .any((up) => up.map((e) => e.position).toSet().length != up.length)) {
    //   throw 'Duplicate external cards.';
    // }
    for (final up in updates.entries) {
      final tableCards = up.key;
      up.value.sort((a, b) => a.position - b.position);
      int numAdded = 0;
      for (final c in up.value) {
        tableCards.insert(c.position + numAdded, c.card);
        numAdded++;
      }
    }
    // TODO: check toDrop null
    topCard.value = cardSet.toDrop;
    player.tableCards.addAll(cardSet.threesomes);
    player.tableCards.addAll(cardSet.stairs);

    player.cards.clear();
    player.cards.insertAll(0, copyCards);
    playerStep.value = ContinentalPlayStep.eating;
    if (player.cards.isEmpty) {
      // won
      _nextGame();
    } else {
      currentPlayerIndex.value =
          (currentPlayerIndex.value! + 1) % players.length;
    }
  }

  ContinentalData dataForPlayer(String playerId) {
    final player = playerById(playerId)!;

    return ContinentalData(
      key: key,
      playerId: playerId,
      step: step.value,
      topCard: topCard.value,
      currentPlayerIndex: currentPlayerIndex.value,
      currentPlayer: currentPlayer.value?.id,
      counts: counts.sublist(0),
      players: players.map((p) => p.id).toList(),
      cards: player.cards.sublist(0),
      // TODO: inner lists
      tableCards: player.tableCards.sublist(0),
      otherTableCards: Map.fromEntries(players.map(
        (p) => MapEntry(p.id, p.tableCards),
      )),
      canPunish: canPunish.value && currentPlayer.value?.id != playerId,
      playerStep: playerStep.value,
    );
  }

  ///
  /// Private

  void _nextGame() {
    counts.add(Map.fromEntries(
      players.map(
        (player) => MapEntry(
          player.id,
          player.cards.fold(0, (v, card) => v + card.n.weight),
        ),
      ),
    ));
    if (step.value == ContinentalStep.eee) {
      // TODO: won whole game
      step.value = ContinentalStep.tt;
    } else {
      step.value = ContinentalStep.values[step.value.index + 1];
    }
    _resetCards();
  }

  void _resetCards() {
    // extractedCards = List.generate(
    //   CardN.values.length,
    //   (index) => index == CardN.joker.index ? 2 : 0,
    // );
    // extractedCardType = {};
    const amount = 2;
    for (var i = 0; i < amount; i++) {
      for (final item in CardN.values) {
        allCards.addAll(Iterable.generate(
          item == CardN.joker ? 3 : 4,
          (index) => Card(
            item,
            CardType.values[index],
          ),
        ));
      }
      allCards.shuffle(_random);
    }

    for (final player in players) {
      player.cards.clear();
      player.cards.insertAll(
        0,
        Iterable.generate(
          step.value.index + 6,
          (_) => _selectNewCard(),
        ),
      );
    }

    currentPlayerIndex.value ??= 0;
  }

  Card _selectNewCard() {
    if (currentCard == allCards.length) {
      allCards.shuffle(_random);
      currentCard = 0;
    }
    return allCards[currentCard++];
    // const amount = 2;
    // final sum = extractedCards.fold<int>(0, (s, element) => s + element);
    // int pos = 52 * amount + 3 * amount - sum;
    // final randIndex = _random.nextInt(pos);

    // CardN? _card;
    // int i = 0;
    // while (_card == null) {
    //   pos -= amount * 4 - extractedCards[i];
    //   if (randIndex > pos) {
    //     _card = CardN.values[i];
    //   }
    //   i++;
    // }
    // extractedCards[_card.index]++;
    // final cardType = CardType.values[_random.nextInt(3)];
    // return Card(_card, cardType);
  }
}

enum ContinentalPlayStep {
  eating,
  dropping,
}

class ContinentalPlayer {
  final String id;
  final ObservableList<Card> cards = ObservableList();
  final tableCards = ObservableList<List<Card>>();

  ContinentalPlayer({
    required this.id,
  });
}

enum CardType {
  heart,
  diamond,
  spade, // picas
  club, // trébol
}

extension CardTypeExt on CardType {
  String get unicode => const ['♥', '♦', '♠', '♣'][index];
}

enum CardN {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  j,
  q,
  k,
  joker,
}

extension CardNExt on CardN {
  int get weight {
    switch (this) {
      case CardN.joker:
        return 50;
      case CardN.one:
        return 20;
      case CardN.j:
      case CardN.q:
      case CardN.k:
        return 10;
      default:
        return index + 1;
    }
  }
}

enum ContinentalStep {
  tt,
  te,
  ee,
  ttt,
  tet,
  ete,
  eee,
}

extension ContinentalStepExt on ContinentalStep {
  int get threesomes => const {
        ContinentalStep.tt: 2,
        ContinentalStep.te: 1,
        ContinentalStep.ee: 0,
        ContinentalStep.ttt: 3,
        ContinentalStep.tet: 2,
        ContinentalStep.ete: 1,
        ContinentalStep.eee: 0,
      }[this]!;
  int get stairs => const {
        ContinentalStep.tt: 0,
        ContinentalStep.te: 1,
        ContinentalStep.ee: 2,
        ContinentalStep.ttt: 0,
        ContinentalStep.tet: 1,
        ContinentalStep.ete: 2,
        ContinentalStep.eee: 3,
      }[this]!;
}
