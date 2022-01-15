import 'dart:math';

import 'package:bootstrap_dart_example/cacho/cacho_command.dart';
import 'package:bootstrap_dart_example/cacho/cacho_store.dart';
import 'package:test/test.dart';

void main() {
  test('cacho store', () {
    final random = Random(42);
    final store = CachoStore(random: random);
    const id1 = 'id1';
    const id2 = 'id2';
    store.addPlayer(id1);
    store.addPlayer(id2);

    expect(store.playerOrder, [id1, id2]);
    expect(store.players.length, 2);
    expect(store.isPlaying.value, false);

    store.start();
    expect(store.isPlaying.value, true);
    expect(store.playerNumber.value, 2);
    expect(store.currentSuggestion.value, null);
    expect(store.currentDiceSuggestion.value, null);
    expect(store.salpiconedPlayers, isEmpty);
    expect(store.currentPlayer.value, id1);

    expect(store.players[id1]!.dices, [5, 1, 1, 1, 4]);
    expect(store.players[id2]!.dices, [2, 3, 1, 2, 3]);

    expect(store.currentSuggestion.value, null);
    final suggestion = Suggestion.dices(amount: 2, dice: 2);
    store.suggest(suggestion);
    expect(store.currentSuggestion.value, suggestion);
    expect(store.currentDiceSuggestion.value, suggestion);
    expect(store.currentPlayer.value, id2);
    expect(store.previousPlayerModel.value?.id, id1);

    store.suggest(Suggestion.salpicon);
    expect(store.currentSuggestion.value, Suggestion.salpicon);
    expect(store.currentDiceSuggestion.value, suggestion);
    expect(store.currentPlayer.value, id1);
    expect(store.previousPlayerModel.value?.id, id2);
    expect(store.salpiconedPlayers, {id2});

    store.dudar();

    /// Won id1

    expect(store.players[id1]!.dices.length, 5);
    expect(store.players[id2]!.dices.length, 4);
    expect(store.currentPlayer.value, id2);
    expect(store.previousPlayerModel.value?.id, id1);
    expect(store.isPlaying.value, true);
    expect(store.playerNumber.value, 2);
    expect(store.currentSuggestion.value, null);
    expect(store.currentDiceSuggestion.value, null);
    expect(store.salpiconedPlayers, isEmpty);

    expect(store.players[id1]!.dices, [4, 3, 4, 4, 2]);
    expect(store.players[id2]!.dices, [5, 4, 1, 5]);
  });
}
