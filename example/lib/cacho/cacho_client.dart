import 'dart:async';

import 'package:artemis/client.dart';
import 'package:bootstrap_dart_example/api.graphql.dart';
import 'package:mobx/mobx.dart';

class CachoClient {
  final ArtemisClient client;

  String? playerId;

  final _errorsController = StreamController<String>.broadcast();
  Stream<String> get errors => _errorsController.stream;
  StreamSubscription? _subs;

  CachoClient({
    required this.client,
  }) {
    _subs = client
        .stream(CachoStateSubscription(
      variables: CachoStateArguments(gameId: ''),
    ))
        .listen((event) {
      final data = event.data;
      if (data != null) {
        this.data.value = data.cachoState;
      }
    });
  }

  Future<void> dispose() async {
    await _subs!.cancel();
    await _errorsController.close();
  }

  final isLoading = Observable(false);
  final data = Observable<CachoState$Subscription$CachoData?>(null);

  Future<T?> _load<T>(Future<T> Function() fn) async {
    if (isLoading.value) return null;
    isLoading.value = true;
    try {
      return await fn();
    } finally {
      isLoading.value = false;
    }
  }

  void sendCommand(CachoCommandInput command) async {
    await _load(() async {
      final response = await client.execute(SendCachoCommandMutation(
        variables: SendCachoCommandArguments(
          gameId: data.value!.id,
          command: command,
        ),
      ));
      if (response.hasErrors) {
        _errorsController.add(response.errors!.first.message);
      } else {
        final data = response.data!;
        final error = data.sendCachoCommand;
        if (error != null) {
          _errorsController.add(error);
        }
      }
    });
  }
}
