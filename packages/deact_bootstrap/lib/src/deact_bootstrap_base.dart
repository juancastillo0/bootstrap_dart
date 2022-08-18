import 'package:universal_html/html.dart';
import 'package:deact/deact.dart' as deact;
import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';

class DeactBootstrapRenderer implements BootstrapRenderer<deact.DeactNode> {
  const DeactBootstrapRenderer();

  static void setUp() {
    bootstrapRenderer = const DeactBootstrapRenderer();
  }

  @override
  el(
    String tag, {
    Map<String, String>? attributes,
    Iterable<dynamic>? children,
    Object? key,
    Map<String, void Function(Event p1)>? listeners,
    Ref<Element?>? ref,
  }) {
    return deact.el(
      tag,
      attributes: attributes,
      children: children?.cast(),
      key: key,
      listeners: listeners,
      ref: (ref as DeactBootstrapRef<Element?>?)?.ref,
    );
  }

  @override
  fc(dynamic Function(BootstrapBuildContext p1) builder, {Object? key}) {
    return deact.fc((ctx) => builder(ctx.bootstrapCtx), key: key);
  }

  @override
  fragment(List<dynamic> children) {
    return deact.fragment(children.cast());
  }

  @override
  txt(String text) {
    return deact.txt(text);
  }
}

class DeactBootstrapContext extends BootstrapBuildContext {
  final deact.ComponentContext ctx;

  DeactBootstrapContext(this.ctx);

  @override
  void hookEffect(
    void Function()? Function() effect, [
    List<Object?>? keys,
    bool Function(Object? p1, Object? p2)? equals,
  ]) {
    ctx.hookEffect(effect, keys, equals ?? deact.defaultKeysEquals);
  }

  @override
  Ref<T> hookRef<T>(T Function() create) {
    return ctx.hookRef(create).bootstrapRef;
  }

  @override
  Ref<T> hookState<T>(T Function() create) {
    return ctx.hookState(create).bootstrapRef;
  }

  @override
  operator ==(Object other) =>
      other is DeactBootstrapContext && other.ctx == ctx;

  @override
  int get hashCode => ctx.hashCode;
}

extension BootstrapContextExt on deact.ComponentContext {
  BootstrapBuildContext get bootstrapCtx => DeactBootstrapContext(this);
}

class DeactBootstrapRef<T> implements Ref<T> {
  final deact.Ref<T>? ref;
  final deact.State<T>? state;

  bool get isState => state != null;

  DeactBootstrapRef.ref(deact.Ref<T> this.ref) : state = null;
  DeactBootstrapRef.state(deact.State<T> this.state) : ref = null;

  @override
  T get value => isState ? state!.value : ref!.value;

  @override
  set value(T v) => isState ? state!.value = v : ref!.value = v;

  @override
  operator ==(Object other) =>
      other is DeactBootstrapRef && other.ref == ref && other.state == state;

  @override
  int get hashCode => ref.hashCode ^ state.hashCode;
}

extension BootstrapRefExt<T> on deact.Ref<T> {
  Ref<T> get bootstrapRef => DeactBootstrapRef.ref(this);
}

extension BootstrapStateExt<T> on deact.State<T> {
  Ref<T> get bootstrapRef => DeactBootstrapRef.state(this);
}
