// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:universal_html/html.dart' as html;

import 'hooks.dart';
import 'server_renderer.dart';

class BaseRouteParams<A> {
  final Uri uri;
  final RouteReq? req;
  final A param;
  final ComponentContext ctx;

  const BaseRouteParams({
    required this.uri,
    required this.req,
    required this.param,
    required this.ctx,
  });
}

class RouteParams<A, T> implements BaseRouteParams<A> {
  @override
  final Uri uri;
  @override
  final RouteReq? req;
  @override
  final A param;
  @override
  final ComponentContext ctx;

  final T? data;
  final bool isLoaded;

  const RouteParams({
    required this.uri,
    required this.req,
    required this.param,
    required this.ctx,
    required this.data,
    required this.isLoaded,
  });
}

abstract class Route<A, T> {
  const Route();

  String get path;

  ReqParser<A> get parser;

  FutureOr<T> load(BaseRouteParams<A> input);

  DeactNode render(RouteParams<A, T> value);

  DeactNode wrapper(DeactNode child) => child;

  bool get isStaticPath => path.split('/').every((p) => !p.startsWith(':'));

  RouteMatch<A> matchRoute(Uri uri, RouteReq? req) {
    final path = this.path;
    final splitPath = path.split('/').where((p) => p.isNotEmpty).toList();
    final paths = uri.pathSegments.where((p) => p.isNotEmpty).toList();
    int i = 0;
    final noMatch = paths.length != splitPath.length ||
        splitPath.any((p) => !p.startsWith(':') && p != paths[i]);
    if (noMatch) {
      return RouteMatch(matches: false, param: null);
    }
    try {
      final data = this.parser.fromReq(uri, req);
      return RouteMatch(matches: true, param: data);
    } catch (_) {
      return RouteMatch(matches: false, param: null);
    }
  }

  DeactNode renderRoute(
    A arg, {
    RouteReq? req,
    void Function()? onLoad,
  }) {
    return this.wrapper(fc((ctx) {
      final uri = req?.uri ?? Uri.parse('');

      final loadFuture = useMemo(ctx, () {
        final baseParams = BaseRouteParams(
          uri: uri,
          req: req,
          param: arg,
          ctx: ctx,
        );
        return this.load(baseParams);
      });
      final data =
          ctx.hookRef<T?>(() => loadFuture is! Future<T> ? loadFuture : null);
      final isLoaded = ctx.hookState(() => loadFuture is! Future<T>);
      ctx.hookEffect(() {
        if (loadFuture is Future<T>) {
          loadFuture.then((value) {
            data.value = value;
            isLoaded.value = true;
            onLoad?.call();
          });
        } else {
          onLoad?.call();
        }
      }, const []);

      final params = RouteParams<A, T>(
        data: data.value,
        isLoaded: isLoaded.value,
        param: arg,
        req: req,
        uri: uri,
        ctx: ctx,
      );
      final child = this.render(params);
      return child;
    }));
  }
}

Future<TemplateWithRendered> renderUrl({
  required DRouter router,
  required Uri url,
  required String template,
  required String selector,
}) async {
  final comp = Completer<void>();
  final rendered = router.setup(RouteReq(url), onLoad: comp.complete);

  final renderer = await renderIsomorphic(selector, () => rendered.node);
  await comp.future;
  await renderer.renderer.waitScheduledRender();

  return TemplateWithRendered(
    template: renderer.renderInTemplate(template),
    rendered: rendered,
  );
}

class TemplateWithRendered {
  final RenderedRoute rendered;
  final String template;

  TemplateWithRendered({
    required this.rendered,
    required this.template,
  });
}

class DNavigator {
  final DRouter router;

  DNavigator(this.router);

  void pushNamed(String href, {bool replaceState = true}) {
    final uri = Uri.parse(href);
    if (replaceState) {
      html.window.history.pushState(router.stack.length, '', uri.toString());
    }

    router.stack.add(router.setup(null)); // RouteReq(uri)
    router.updateCurrent();
  }
}

class RenderedRoute {
  final DeactNode node;
  final Route? route;
  final Uri uri;
  final int? state;

  RenderedRoute({
    required this.node,
    required this.route,
    required this.uri,
  }) : state = kIsWeb && html.window.history.state is int
            ? (html.window.history.state as int)
            : null;
}

PropsMapper propMapper(DRouter router) {
  return (tag, props) {
    if (tag != 'a') return props;
    String? href;
    String? target;
    Object? onclick;
    String? attr;
    for (final p in props ?? []) {
      if (attr == null) {
        attr = p;
      } else {
        if (attr == 'href') {
          href = p;
        } else if (attr == 'target') {
          target = p;
        } else if (attr == 'onclick') {
          onclick = p;
        }
        attr = null;
      }
    }
    if (href == null ||
        onclick != null ||
        (target != null && target != '_self')) return props;

    return [
      ...props!,
      'onclick',
      (html.Event event) {
        event.preventDefault();
        router.navigator.pushNamed(href!);
      }
    ];
  };
}

RenderedRoute useSelectedRoute(ComponentContext ctx) {
  final router = ctx.scoped(DRouter.scope);
  final route = ctx.scoped(DRouter._routeScope);
  final result = useStream(
    ctx,
    router.currentRouteStream,
    initialValue: () => route,
  );
  return result.asValue!.value;
}

class DRouter extends ComponentNode {
  final List<Route> routes;
  final DeactNode fallback;
  late final DNavigator navigator = DNavigator(this);
  final List<RenderedRoute> stack = [];
  int _count = 0;

  RenderedRoute get currentRoute => stack.last;
  Stream<RenderedRoute> get currentRouteStream =>
      _currentRouteController.stream;
  final StreamController<RenderedRoute> _currentRouteController =
      StreamController.broadcast();

  DRouter({
    required Iterable<Route> routes,
    required this.fallback,
    Object? key,
    this.wrapper,
  })  : routes = [...routes]..sort((a, b) => a.path.compareTo(b.path)),
        super(key: key);

  DeactNode Function(RenderedRoute)? wrapper;

  RenderedRoute wrapRoute(RenderedRoute route, RouteReq? req) {
    final node = wrapper != null ? wrapper!(route) : route.node;

    return RenderedRoute(
      node: fc(
        (ctx) {
          ctx.setUpScoped(scope, this);
          ctx.setUpScoped(routeReqScope, req);
          ctx.setUpScoped(_routeScope, route);
          return node;
        },
      ),
      route: route.route,
      uri: route.uri,
    );
  }

  void updateCurrent() {
    _count++;
    _currentRouteController.add(currentRoute);
  }

  RenderedRoute setup(
    RouteReq? req, {
    void Function()? onLoad,
  }) {
    final uri = req?.uri ?? Uri.parse(html.window.location.href);

    RenderedRoute? rendered;
    for (final route in routes) {
      final match = route.matchRoute(uri, req);
      if (match.matches) {
        final node = route.renderRoute(
          match.param,
          req: req,
          onLoad: onLoad,
        );

        rendered = RenderedRoute(
          node: node,
          route: route,
          uri: uri,
        );
      }
    }
    if (rendered == null) {
      onLoad?.call();
      rendered = RenderedRoute(
        node: fallback,
        route: null,
        uri: uri,
      );
    }

    return wrapRoute(rendered, req);
  }

  static final scope = Scoped<DRouter>((_) => throw Error());
  static final routeReqScope = Scoped<RouteReq?>((_) => null);
  static final _routeScope = Scoped<RenderedRoute>((_) => throw Error());

  @override
  DeactNode render(ComponentContext ctx) {
    if (stack.isEmpty) {
      stack.add(setup(null));
    }
    useStream(
      ctx,
      currentRouteStream,
      initialValue: () => stack.last,
    );
    ctx.hookEffect(() {
      if (kIsWeb) {
        final subs = html.window.onPopState.listen((event) {
          final prev = stack.length > 1 ? stack[stack.length - 2] : null;
          print(
            'd:${event.state} href: ${html.window.location.href} last:${stack.last.uri.toString()}'
            ' prev:${prev?.uri.toString() ?? 'N'}',
          );
          if (prev != null &&
              html.window.location.href == prev.uri.toString() &&
              (event.state == null || event.state == prev.state)) {
            print('remove ${event.state} ${stack.length}');
            stack.removeLast();
            updateCurrent();
          } else {
            print('add ${event.state} ${stack.length}');
            // if (event.state != html.window.history.state ||
            //     html.window.location.href != stack.last.uri.toString())
            navigator.pushNamed(html.window.location.href, replaceState: false);
          }
        });

        return () => subs.cancel();
      }
    }, const []);
    return fragment([
      div(
        className: 'd-flex flex-column',
        children: [
          ...stack.map(
            (e) => span(
              className: 'm-1',
              children: [
                txt(
                  e.uri
                      .toString()
                      .replaceFirst('${e.uri.scheme}://${e.uri.authority}', ''),
                ),
              ],
            ),
          )
        ],
      ),
      fc(
        (ctx) => stack.last.node,
        key: _count.toString(),
      ),
    ]);
  }
}

class RouteMatch<A> {
  final bool matches;
  final A? param;

  RouteMatch({
    required this.matches,
    this.param,
  });
}

mixin NoLoadRoute<A> on Route<A, void> {
  @override
  FutureOr<void> load(BaseRouteParams<A> input) => null;
}

abstract class StaticRoute extends Route<void, void>
    with NoParamRoute<void>, NoLoadRoute<void> {
  const StaticRoute(this.path);

  @override
  final String path;
}

mixin NoParamRoute<T> on Route<void, T> {
  @override
  ReqParser<void> get parser => const _NullReqParser();
}

class SingleIdParser implements ReqParser<String> {
  const SingleIdParser([this.index = 1]);
  final int index;

  @override
  String fromReq(Uri uri, RouteReq? req) => uri.pathSegments[index];

  @override
  PartialUri toUri(String value) => PartialUri([value], {});
}

class _NullReqParser implements ReqParser<void> {
  const _NullReqParser();

  @override
  void fromReq(Uri uri, RouteReq? req) {}

  @override
  PartialUri toUri(void value) => const PartialUri([''], {});
}

abstract class ReqParser<A> {
  A fromReq(Uri uri, RouteReq? req);

  PartialUri toUri(A value);
}

class RouteReq {
  final Uri uri;

  RouteReq(this.uri);
}

class PartialUri {
  final List<String> path;
  final Map<String, String> params;

  const PartialUri(this.path, this.params);
}
