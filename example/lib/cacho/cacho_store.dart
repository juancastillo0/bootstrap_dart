import 'dart:math';

import 'package:bootstrap_dart_example/cacho/cacho_command.dart';
import 'package:bootstrap_dart_example/mobx_helpers.dart';
import 'package:mobx/mobx.dart';

class CachoData {
  final int totalDices;
  final bool canCazar;
  final int? minAs;
  final int? minOther;
  final bool isPlaying;
  final int playerNumber;
  final List<String> players;
  final String? currentPlayer;
  final String? previousPlayer;
  final Suggestion? currentSuggestion;
  final SuggestionDices? currentDiceSuggestion;
  final List<int> dices;
  final List<String> salpiconedPlayers;

  CachoData({
    required this.totalDices,
    required this.canCazar,
    required this.minAs,
    required this.minOther,
    required this.isPlaying,
    required this.playerNumber,
    required this.players,
    required this.currentPlayer,
    required this.previousPlayer,
    required this.currentSuggestion,
    required this.currentDiceSuggestion,
    required this.dices,
    required this.salpiconedPlayers,
  });
}

class CachoStore extends TreeStore<CachoCommand, String> {
  CachoStore({Random? random}) : _random = random ?? Random() {
    setUp();
  }
  final Random _random;

  void setUp() {
    on<CachoCommandSuggest>((c) => suggest(c.suggestion));
    on<CachoCommandCazar>((c) => cazar());
    on<CachoCommandDudar>((c) => dudar());
    on<CachoCommandStart>((c) => start());
  }

  @override
  void onSuccess(CachoCommand command) {}

  ///
  /// Observables/State

  late final state = obs(CachoPlayState.idle);
  late final currentSuggestion = obs<Suggestion?>(null);
  late final currentDiceSuggestion = obs<SuggestionDices?>(null);
  final salpiconedPlayers = ObservableSet<String>();
  late final currentPlayer = obs<String?>(null);

  final players = ObservableMap<String, CachoPlayerStore>();
  final playerOrder = ObservableList<String>();
  late final playerModel = Computed(() => players[currentPlayer.value]);
  late final previousPlayerModel = Computed(() {
    final player = playerModel.value;
    if (player == null) return null;
    final index = playerOrder.indexOf(player.id);
    final prevId = index == 0 ? playerOrder.last : playerOrder[index - 1];
    return players[prevId];
  });

  ///
  /// Computed

  late final totalDices = Computed(() => players.values.fold<int>(
      0, (previousValue, player) => player.dices.length + previousValue));
  late final canCazar = Computed(() =>
      currentDiceSuggestion.value != null &&
      totalDices.value / (players.length * 5) > 0.5);
  late final minAs = Computed(() {
    final _diceSug = currentDiceSuggestion.value;
    if (_diceSug == null) return null;
    if (_diceSug.dice == 1) return _diceSug.amount + 1;
    return _diceSug.amount ~/ 2 + 1;
  });
  late final minOther = Computed(() {
    final _diceSug = currentDiceSuggestion.value;
    if (_diceSug == null) return null;
    if (_diceSug.dice == 1) return _diceSug.amount * 2 + 1;
    return _diceSug.amount;
  });
  late final isPlaying = Computed(() => playerNumber.value >= 2);
  late final playerNumber = Computed(
      () => players.values.where((player) => player.isPlaying.value).length);

  int amountForDice(int dice) {
    return players.values.fold(
        0,
        (previousValue, player) =>
            previousValue + player.dices.where((d) => d == dice).length);
  }

  CachoData data(String playerId) {
    return CachoData(
      totalDices: totalDices.value,
      canCazar: canCazar.value,
      minAs: minAs.value,
      minOther: minOther.value,
      isPlaying: isPlaying.value,
      playerNumber: playerNumber.value,
      players: playerOrder,
      currentPlayer: currentPlayer.value,
      previousPlayer: previousPlayerModel.value?.id,
      currentSuggestion: currentSuggestion.value,
      currentDiceSuggestion: currentDiceSuggestion.value,
      dices: players[playerId]!.dices,
      salpiconedPlayers: salpiconedPlayers.toList(),
    );
  }

  ///
  /// Actions

  late final addPlayer = Action1('addPlayer', (String id) {
    if (!players.containsKey(id)) {
      players[id] = CachoPlayerStore(id);
      playerOrder.add(id);
    }
  });

  late final start = Action(() {
    _next(loser: null);
  });

  late final suggest = Action1('suggest', (Suggestion suggestion) {
    final currentPlayerId = currentPlayer.value;
    if (currentPlayerId == null) throw 'Not playing.';

    if (suggestion is SuggestionDices) {
      final currentSuggestion = currentDiceSuggestion.value;
      if (currentSuggestion != null &&
          currentSuggestion.compareTo(suggestion) > 0) {
        throw 'Invalid suggestion, should be greater than $currentSuggestion.';
      }

      currentDiceSuggestion.value = suggestion;
    } else if (suggestion is SuggestionSalpicon) {
      if (playerModel.value!.dices.length != 5 ||
          salpiconedPlayers.contains(currentPlayerId)) {
        throw "Can't suggest salpicón.";
      }
      salpiconedPlayers.add(currentPlayerId);
    }
    currentSuggestion.value = suggestion;

    final index = playerOrder.indexOf(currentPlayer.value);
    // TODO: next that is playing
    currentPlayer.value = index == playerOrder.length - 1
        ? playerOrder.first
        : playerOrder[index + 1];
  });

  late final cazar = Action(() {
    final _diceSug = currentDiceSuggestion.value;
    if (!canCazar.value || _diceSug == null) throw "Can't cazar.";

    final amount = amountForDice(_diceSug.dice);
    final player = playerModel.value!;
    if (amount == _diceSug.amount) {
      _increasePlayerDice(player);
    } else {
      _decreasePlayerDice(player);
      _decreasePlayerDice(player);
    }
    _next(loser: player);
  });

  late final dudar = Action(() {
    final _diceSug = currentSuggestion.value;
    final otherPlayer = previousPlayerModel.value;
    if (_diceSug == null || otherPlayer == null) throw "Can't doubt.";
    final player = playerModel.value!;

    final bool lost;
    if (_diceSug is SuggestionDices) {
      final amount = amountForDice(_diceSug.dice);
      lost = amount > _diceSug.amount;
    } else if (_diceSug is SuggestionSalpicon) {
      lost = otherPlayer.dices.toSet().length == 5;
    } else {
      throw Error();
    }
    final loser = lost ? player : otherPlayer;
    _decreasePlayerDice(loser);
    _next(loser: loser);
  });

  /// Private

  void _increasePlayerDice(CachoPlayerStore player) {
    player.dices.add(0);
  }

  void _decreasePlayerDice(CachoPlayerStore player) {
    if (player.isPlaying.value) {
      player.dices.removeLast();
    }
  }

  void _next({required CachoPlayerStore? loser}) {
    if (!isPlaying.value) {
      for (final player in players.values) {
        player.dices.clear();
        player.dices.insertAll(0, Iterable.generate(5));
      }
    }
    for (final player in players.values) {
      player.dices.setAll(
        0,
        Iterable.generate(
          player.dices.length,
          (_) => _random.nextInt(5) + 1,
        ),
      );
    }
    salpiconedPlayers.clear();
    currentSuggestion.value = null;
    currentDiceSuggestion.value = null;
    if (loser != null) {
      if (loser.isPlaying.value) {
        currentPlayer.value = loser.id;
      } else {
        final minCount = players.values
            .where((player) => player.isPlaying.value)
            .map((p) => p.dices.length)
            .reduce(min);
        final index = playerOrder.indexOf(loser.id);
        currentPlayer.value = playerOrder
            .sublist(index, players.length)
            .followedBy(playerOrder.sublist(0, index))
            .firstWhere((player) => players[player]!.dices.length == minCount);
      }
    } else if (players.isNotEmpty) {
      currentPlayer.value = playerOrder.first;
    }
  }
}

enum CachoPlayState {
  idle,
  playing,
}

class CachoPlayerStore {
  final String id;
  final dices = ObservableList<int>();

  late final isPlaying = Computed(() => dices.isNotEmpty);

  CachoPlayerStore(this.id);
}
