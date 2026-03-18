import 'package:jaspr/dom.dart' show Styles;
import 'package:universal_web/web.dart' as web;
import 'package:jaspr/jaspr.dart' as jaspr;
import '../bootstrap/bootstrap_renderer.dart';

export '../bootstrap/bootstrap_core.dart'
    show BSize, ResponsiveBreakPoint, BColor;
export '../src/js_bindings_interface.dart'
    if (dart.library.html) '../src/js_bindings.dart';
export '../bootstrap/bootstrap_renderer.dart'
    show BootstrapBuildContext, Ref, Obs;

typedef ElementAttributes = Map<String, String>;

typedef DeactNode = jaspr.Component;

DeactNode el(
  String tag, {
  ElementAttributes? attributes,
  Iterable<DeactNode>? children,
  Object? key,
  Map<String, void Function(web.Event)>? listeners,
  Ref<web.Element?>? ref,
}) => bootstrapRenderer.el(
  tag,
  attributes: attributes,
  children: children,
  key: key,
  listeners: listeners,
  ref: ref,
);

DeactNode txt(String text) => bootstrapRenderer.txt(text);

// DeactNode fragment(List<DeactNode> children) =>
//     bootstrapRenderer.fragment(children);

DeactNode fc(
  DeactNode Function(BootstrapBuildContext) builder, {
  Object? key,
}) => bootstrapRenderer.fc(builder, key: key);

DeactNode divEl({
  Object? key,
  String? className,
  Iterable<DeactNode>? children,
  String? id,
  String? style,
  void Function(web.MouseEvent)? onclick,
}) => el(
  'div',
  key: key,
  attributes: ({
    'class': className,
    'id': id,
    'style': style,
  }..removeWhere((key, value) => value == null)).cast(),
  listeners: onclick == null
      ? null
      : {'onclick': (e) => onclick(e as web.MouseEvent)},
  children: children,
);

Ref<web.Element?> useSetUpElement(
  BootstrapBuildContext ctx, {
  void Function(web.Element)? onSetUp,
  void Function()? onDispose,
}) {
  final elemRef = ctx.hookRef<web.Element?>(() => null);
  bool disposed = false;

  ctx.hookEffect(() {
    Future(() {
      if (!disposed && elemRef.value != null) {
        onSetUp?.call(elemRef.value!);
      }
    });
    return () {
      disposed = true;
      onDispose?.call();
    };
  }, const []);
  return elemRef;
}

Styles parseStyles(String rawString) => Styles(
  raw: Map.fromEntries(
    rawString.split(';').map((e) {
      final s = e.split(':');
      if (e.length != 2) return null;
      return MapEntry(s[0].trim(), s[1].trim());
    }).nonNulls,
  ),
);
