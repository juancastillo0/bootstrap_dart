import 'package:bootstrap_dart/router.dart';
import 'package:bootstrap_dart/server_renderer.dart';
import 'package:deact/deact.dart';
import 'package:universal_io/io.dart' as io;
import 'package:bootstrap_dart_example/route_example.dart';

void main() async {
  final router = appRouter();

  if (kIsWeb) {
    await renderIsomorphic(
      'output',
      () => router,
      htmlRenderer: IncDomRenderer(mapProps: propMapper(router)),
    );
  } else {
    const dir = 'build';
    final indexFile = io.File('./$dir/index.html');
    final template = await indexFile.readAsString();
    for (final route in router.routes.where((route) => route.isStaticPath)) {
      final rendered = await renderUrl(
        router: router,
        url: Uri.parse(route.path),
        template: template,
        selector: 'output',
      );
      final htmlStr = rendered.template;
      if (route.path == '/') {
        await indexFile.writeAsString(htmlStr);
      } else {
        final file =
            await io.File('./$dir/${route.path}.html').create(recursive: true);
        await file.writeAsString(htmlStr);
      }
    }
  }
}
