import 'package:mobx_hooks_experiment/mobx_hooks/hooks.dart' show useMemo;
import 'package:universal_html/html.dart' as html;
import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:mobx_hooks_experiment/mobx_hooks/mobx_hooks.dart'
    as jaspr_hooks;
import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';

class JasprBootstrapRenderer implements BootstrapRenderer<jaspr.Component> {
  const JasprBootstrapRenderer();

  static void setUp() {
    bootstrapRenderer = const JasprBootstrapRenderer();
  }

  @override
  el(
    String tag, {
    Map<String, Object?>? attributes,
    Iterable<dynamic>? children,
    Object? key,
    Map<String, void Function(html.Event p1)>? listeners,
    Ref<html.Element?>? ref,
  }) {
    return fc((ctx) {
      final attrId = attributes?['id'] as String?;
      final id = useMemo(() => attrId ?? ctx.hashCode.toString(), [attrId]);
      ctx.hookEffect(
        () {
          if (!jaspr.kIsWeb || ref == null) return;
          Future.microtask(() {
            final elem = html.document.getElementById(id);
            if (elem != null) {
              ref.value = elem;
            }
          });
          return null;
        },
        [id, ref],
      );

      return jaspr.DomComponent(
        tag: tag,
        attributes: attributes == null
            ? null
            : ({...attributes}..removeWhere((key, value) => value == null))
                .cast(),
        children: children?.cast<jaspr.Component>().toList(),
        events: listeners?.map((key, value) => MapEntry(key, (e) => value(e))),
        id: attrId != null || ref != null ? id : null,
        key: key == null ? null : jaspr.ValueKey(key),
        // ref: (ref as JasprBootstrapRef<Element?>?)?.ref,
      );
    });
  }

  @override
  fc(dynamic Function(BootstrapBuildContext p1) builder, {Object? key}) {
    return jaspr.Builder(
      builder: (ctx) {
        final child = builder(ctx.bootstrapCtx);
        return child is Iterable ? child.cast() : [child];
      },
      key: key == null ? null : jaspr.ValueKey(key),
    );
  }

  @override
  fragment(List<dynamic> children) {
    return fc((ctx) => children);
  }

  @override
  txt(String text) {
    return jaspr.Text(text);
  }
}

class JasprBootstrapContext extends BootstrapBuildContext {
  final jaspr.BuildContext ctx;

  JasprBootstrapContext(this.ctx);

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
    return jaspr_hooks.useRef(create).bootstrapRef;
  }

  @override
  Ref<T> hookState<T>(T Function() create) {
    return jaspr_hooks.useObs(create).bootstrapRef;
  }

  @override
  operator ==(Object other) =>
      other is JasprBootstrapContext && other.ctx == ctx;

  @override
  int get hashCode => ctx.hashCode;
}

extension BootstrapContextExt on jaspr.BuildContext {
  BootstrapBuildContext get bootstrapCtx => JasprBootstrapContext(this);
}

class JasprBootstrapRef<T> implements Ref<T> {
  final jaspr_hooks.Ref<T>? ref;
  final jaspr_hooks.Obs<T>? state;

  bool get isState => state != null;

  JasprBootstrapRef.ref(jaspr_hooks.Ref<T> this.ref) : state = null;
  JasprBootstrapRef.state(jaspr_hooks.Obs<T> this.state) : ref = null;

  @override
  T get value => isState ? state!.value : ref!.value;

  @override
  set value(T v) => isState ? state!.value = v : ref!.value = v;

  @override
  operator ==(Object other) =>
      other is JasprBootstrapRef && other.ref == ref && other.state == state;

  @override
  int get hashCode => ref.hashCode ^ state.hashCode;
}

extension BootstrapRefExt<T> on jaspr_hooks.Ref<T> {
  Ref<T> get bootstrapRef => JasprBootstrapRef.ref(this);
}

extension BootstrapStateExt<T> on jaspr_hooks.Obs<T> {
  Ref<T> get bootstrapRef => JasprBootstrapRef.state(this);
}
