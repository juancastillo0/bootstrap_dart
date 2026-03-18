import 'package:bootstrap_dart/mobx_hooks/hooks.dart' show useMemo;
import 'package:universal_web/web.dart' as html;
import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:bootstrap_dart/mobx_hooks/mobx_hooks.dart' as jaspr_hooks;
import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';

class JasprBootstrapRenderer implements BootstrapRenderer<jaspr.Component> {
  const JasprBootstrapRenderer();

  @override
  el(
    String tag, {
    Map<String, String>? attributes,
    Iterable<dynamic>? children,
    Object? key,
    Map<String, void Function(html.Event p1)>? listeners,
    Ref<html.Element?>? ref,
  }) {
    return fc(key: key, (ctx) {
      final attrId = attributes?['id'];
      final id = useMemo(() => attrId ?? ctx.hashCode.toString(), [attrId]);
      ctx.hookEffect(() {
        if (!jaspr.kIsWeb || ref == null) return;
        final elem = html.document.getElementById(id);
        if (elem != null) {
          ref.value = elem;
        }
        return null;
      }, [id, ref]);
      final elemId = attrId != null || ref != null ? id : null;
      return jaspr.Component.element(
        tag: tag,
        attributes: attributes,
        children: children?.cast<jaspr.Component>().toList(),
        events: listeners?.map(
          (key, value) => MapEntry(
            key.substring(2), // remove on. oninput -> input
            (e) => value(e),
          ),
        ),
        id: elemId,
        // ref: (ref as JasprBootstrapRef<Element?>?)?.ref,
      );
    });
  }

  @override
  fc(
    jaspr.Component Function(BootstrapBuildContext p1) builder, {
    Object? key,
  }) {
    return jaspr.Builder(
      builder: (ctx) {
        final child = builder(_JasprBootstrapContext(ctx));
        return child;
      },
      key: key == null ? null : jaspr.ValueKey(key),
    );
  }

  @override
  fragment(List<jaspr.Component> children) {
    return jaspr.Component.fragment(children);
  }

  @override
  txt(String text) {
    return jaspr.Component.text(text);
  }
}

class _JasprBootstrapContext extends BootstrapBuildContext {
  @override
  final jaspr.BuildContext ctx;

  _JasprBootstrapContext(this.ctx);

  @override
  void hookEffect(
    void Function()? Function() effect, [
    List<Object?>? keys,
    bool Function(Object? p1, Object? p2)? equals,
  ]) {
    jaspr_hooks.useEffect(
      effect,
      keys,
      equals ?? jaspr_hooks.defaultKeysEquals,
    );
  }

  @override
  Ref<T> hookRef<T>(T Function() create) {
    return jaspr_hooks.useRef(create);
  }

  @override
  Obs<T> hookState<T>(T Function() create) {
    return jaspr_hooks.useObs(create);
  }

  @override
  operator ==(Object other) =>
      other is _JasprBootstrapContext && other.ctx == ctx;

  @override
  int get hashCode => ctx.hashCode;
}
