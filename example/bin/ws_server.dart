import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

class WsServer {
  final WebSocketChannel channel;
  late final StreamSubscription subs;

  String? userId;

  WsServer(this.channel) {
    subs = channel.stream.listen((event) {
      if (event is! String) dispose();

      if (userId != null) {
        userId = event;
      }
    });
  }

  void dispose() {
    subs.cancel();
  }
}
