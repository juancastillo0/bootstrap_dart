import 'dart:async';
import 'dart:convert';

import 'package:bootstrap_dart_example/cacho/cacho_command.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:universal_html/html.dart' as html;

class CachoApi {
  final WebSocketChannel _channel;
  late final StreamSubscription subs;

  CachoApi(this._channel) {
    subs = _channel.stream.listen((event) {
      try {
        final payload = json.decode(event as String) as Map<String, Object?>;
      } catch (e, s) {
        print('$e $s');
        dispose();
      }
    });
  }

  void sendCommand(String gameId, CachoCommand command) {
    _channel.sink.add(json.encode({
      'type': 'cachoCommand',
      'gameId': gameId,
      'command': command.toJson(),
    }));
  }

  void dispose() {
    subs.cancel();
  }
}
