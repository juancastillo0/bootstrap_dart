import 'package:universal_html/html.dart' as html;
import '../bootstrap/bootstrap_renderer.dart';

export '../bootstrap/bootstrap_core.dart'
    show BSize, ResponsiveBreakPoint, BColor;
export '../src/js_bindings_interface.dart'
    if (dart.library.html) '../src/js_bindings.dart';
export '../bootstrap/bootstrap_renderer.dart'
    show BootstrapBuildContext, Ref, State;

typedef ElementAttributes = Map<String, String>;

typedef DeactNode = dynamic;

DeactNode el(
  String tag, {
  ElementAttributes? attributes,
  Iterable<DeactNode>? children,
  Object? key,
  Map<String, void Function(html.Event)>? listeners,
  Ref<html.Element?>? ref,
}) =>
    bootstrapRenderer.el(
      tag,
      attributes: attributes,
      children: children,
      key: key,
      listeners: listeners,
      ref: ref,
    );

DeactNode txt(String text) => bootstrapRenderer.txt(text);

DeactNode fragment(List<DeactNode> children) =>
    bootstrapRenderer.fragment(children);

DeactNode fc(
  DeactNode Function(BootstrapBuildContext) builder, {
  Object? key,
}) =>
    bootstrapRenderer.fc(builder, key: key);

DeactNode div({
  Object? key,
  String? className,
  Iterable<DeactNode>? children,
  String? id,
  String? style,
  void Function(html.MouseEvent)? onclick,
}) =>
    el(
      'div',
      key: key,
      attributes: ({'class': className, 'id': id, 'style': style}
            ..removeWhere((key, value) => value == null))
          .cast(),
      listeners: onclick == null
          ? null
          : {'onclick': (e) => onclick(e as html.MouseEvent)},
      children: children,
    );

Ref<html.Element?> useSetUpElement(
  BootstrapBuildContext ctx, {
  void Function(html.Element)? onSetUp,
  void Function()? onDispose,
}) {
  final elemRef = ctx.hookRef<html.Element?>(() => null);
  bool disposed = false;

  ctx.hookEffect(
    () {
      Future(() {
        if (!disposed && elemRef.value != null) {
          onSetUp?.call(elemRef.value!);
        }
      });
      return () {
        disposed = true;
        onDispose?.call();
      };
    },
    const [],
  );
  return elemRef;
}
