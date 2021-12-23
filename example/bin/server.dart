import 'dart:async';
import 'dart:io';

import 'package:bootstrap_dart/router.dart';
import 'package:bootstrap_dart_example/route_example.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_proxy/shelf_proxy.dart';

// Run this app with --enable-vm-service (or use debug run)
void main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  return io.serve(await handler(), 'localhost', 8051);
}

Future<Handler> handler() async {
  final router = appRouter();
  final template = await File('./web/index.html').readAsString();
  final proxy = proxyHandler('http://localhost:8050/');

  return (Request request) async {
    final rendered = await renderUrl(
      router: router,
      url: request.url,
      template: template,
      selector: 'output',
    );
    if (rendered.rendered.route == null) {
      final response = await proxy(request);
      if (response.statusCode != 404) return response;
    }
    return Response.ok(
      rendered.template,
      headers: {'content-type': 'text/html'},
    );
  };
}
