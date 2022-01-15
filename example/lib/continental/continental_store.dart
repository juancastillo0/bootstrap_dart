import 'dart:math';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import 'package:bootstrap_dart_example/mobx_helpers.dart';

class ContinentalData {
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

class ContinentalStore extends TreeStore {
  ContinentalStore({Random? random}) : _random = random ?? Random();
  final Random _random;

  @override
  void onSuccess(Object? event) {}

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

  late final addPlayer = Action1('addPlayer', (String playerId) {
    if (playerById(playerId) == null) {
      players.add(ContinentalPlayer(id: playerId));
    } else {
      throw 'Player "$playerId" already in game.';
    }
  });

  late final start = Action(() {
    if (currentPlayerIndex.value != null) return;
    _resetCards();
  });

  late final castigarse = Action1('castigarse', (String playerId) {
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
  });

  late final comer = Action1('comer', (bool newCard) {
    final player = currentPlayer.value;
    if (player == null || playerStep.value != ContinentalPlayStep.eating) {
      throw 'Wrong state for eating.';
    }

    final Card card;
    if (newCard) {
      card = _selectNewCard();
    } else {
      final _card = topCard.value;
      if (_card == null) throw 'No available top card.';
      card = _card;
      topCard.value = null;
    }
    player.cards.add(card);
    playerStep.value = ContinentalPlayStep.dropping;
  });

  late final bajar = Action1('bajar', (CardSet cardSet) {
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
  });

  ContinentalData dataForPlayer(String playerId) {
    final player = playerById(playerId)!;

    return ContinentalData(
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

class CardSet {
  final List<List<Card>> threesomes;
  final List<List<Card>> stairs;
  final List<ExternalCard> external;
  final Card? toDrop;

  const CardSet({
    this.threesomes = const [],
    this.stairs = const [],
    this.external = const [],
    required this.toDrop,
  });

  Iterable<Card> allCards() => threesomes
      .expand((e) => e)
      .followedBy(stairs.expand((e) => e))
      .followedBy(external.map((e) => e.card))
      .followedBy([if (toDrop != null) toDrop!]);

  bool validate() {
    return threesomes.every((cards) {
          final nonJoker = cards.where((c) => c.n != CardN.joker).toList();
          return cards.length == 3 &&
              nonJoker.map((e) => e.n).toSet().length == 1 &&
              nonJoker.map((e) => e.type).toSet().length == nonJoker.length;
        }) &&
        stairs.every((cards) {
          int? p;
          for (final c in cards) {
            if (c.n != CardN.joker) {
              if (p == null || p == c.n.index - 1) {
                p = c.n.index;
              } else {
                return false;
              }
            } else if (p != null) {
              p += 1;
            }
          }
          final nonJoker = cards.where((c) => c.n != CardN.joker).toList();
          return cards.length == 4 &&
              nonJoker.map((e) => e.type).toSet().length == 1;
        });
  }
}

class ExternalCard {
  final Card card;
  final String playerId;
  final int tableCardsId;
  final int position;

  const ExternalCard(
    this.card,
    this.playerId,
    this.tableCardsId,
    this.position,
  );
}

class Card {
  final CardN n;
  final CardType type;

  const Card(this.n, this.type);

  @override
  String toString() => 'Card(n: $n, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Card &&
        other.n == n &&
        (n == CardN.joker || other.type == type);
  }

  @override
  int get hashCode =>
      n == CardN.joker ? n.hashCode : n.hashCode ^ type.hashCode;
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
