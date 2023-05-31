import 'package:universal_html/html.dart' as html;
import 'package:rad/rad.dart' as rad;
import 'package:rad/widgets_html.dart' as rad_html;
import 'package:rad_hooks/rad_hooks.dart' as rad_hooks;
import 'package:rad_bootstrap/src/rad_custom_hooks.dart' as rad_custom_hooks;
import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';

class RadBootstrapRenderer implements BootstrapRenderer<rad.Widget> {
  const RadBootstrapRenderer();

  static void setUp() {
    bootstrapRenderer = const RadBootstrapRenderer();
  }

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
      final id = rad_hooks.useMemo(
        () => attrId ?? ctx.hashCode.toString(),
        [attrId],
      );
      ctx.hookEffect(
        () {
          // !kIsWeb
          if (!identical(0, 0.0) || ref == null) return;
          final elem = html.document.getElementById(id);
          if (elem != null) {
            ref.value = elem;
          }
          return null;
        },
        [id, ref],
      );

      final elemId = attrId != null || ref != null ? id : null;
      return rad.RawEventDetector(
        events: listeners,
        child: CustomTagDomWidget(
          correspondingTag: rad.DomTagType.values.byName(tag),
          additionalAttributes: attributes,
          children: children?.cast<rad.Widget>().toList(),
          id: elemId,
        ),
      );
    });
  }

  @override
  fc(dynamic Function(BootstrapBuildContext p1) builder, {Object? key}) {
    return rad.HookScope(
      () => builder(RadBootstrapContext(rad.useContext())),
      key: _keyFromObject(key),
    );
  }

  @override
  fragment(List<dynamic> children) {
    return MultiChildWidget(children: children.cast());
  }

  @override
  txt(String text) {
    // TODO: test behaviour
    return rad.Text(text);
  }
}

rad.Key? _keyFromObject(Object? object) {
  return object == null
      ? null
      : rad.Key('$object-${object.runtimeType}-${object.hashCode}');
}

class RadBootstrapContext extends BootstrapBuildContext {
  final rad.BuildContext ctx;

  RadBootstrapContext(this.ctx);

  @override
  void hookEffect(
    void Function()? Function() effect, [
    List<Object?>? keys,
    bool Function(Object? p1, Object? p2)? equals,
  ]) {
    rad_custom_hooks.useCustomEffect(effect, keys, equals);
  }

  @override
  Ref<T> hookRef<T>(T Function() create) {
    final initial = rad_hooks.useMemo(create, const []);
    return rad_hooks.useRef(initial).bootstrapRef;
  }

  @override
  Ref<T> hookState<T>(T Function() create) {
    final initial = rad_hooks.useMemo(create, const []);
    return rad_hooks.useState(initial).bootstrapRef;
  }

  @override
  operator ==(Object other) => other is RadBootstrapContext && other.ctx == ctx;

  @override
  int get hashCode => ctx.hashCode;
}

class RadBootstrapRef<T> implements Ref<T> {
  final rad_hooks.UseRefHook<T>? ref;
  final rad_hooks.UseStateHook<T>? state;

  bool get isState => state != null;

  RadBootstrapRef.ref(rad_hooks.UseRefHook<T> this.ref) : state = null;
  RadBootstrapRef.state(rad_hooks.UseStateHook<T> this.state) : ref = null;

  @override
  T get value => isState ? state!.value : ref!.value;

  @override
  set value(T v) => isState ? state!.value = v : ref!.value = v;

  @override
  operator ==(Object other) =>
      other is RadBootstrapRef && other.ref == ref && other.state == state;

  @override
  int get hashCode => ref.hashCode ^ state.hashCode;
}

extension BootstrapRefExt<T> on rad_hooks.UseRefHook<T> {
  Ref<T> get bootstrapRef => RadBootstrapRef.ref(this);
}

extension BootstrapStateExt<T> on rad_hooks.UseStateHook<T> {
  Ref<T> get bootstrapRef => RadBootstrapRef.state(this);
}

/// An HTML dom element widget with dynamic tag.
class CustomTagDomWidget extends rad_html.Division {
  const CustomTagDomWidget({
    required this.correspondingTag,
    rad.Key? key,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    String? innerText,
    rad.Widget? child,
    List<rad.Widget>? children,
    rad.EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @override
  final rad.DomTagType correspondingTag;
}

/// Widgets that has multiple children. Similar to React's fragments.
class MultiChildWidget extends rad.Widget {
  /// The children widgets.
  final List<rad.Widget> children;

  const MultiChildWidget({
    rad.Key? key,
    required this.children,
  }) : super(key: key);

  @override
  createRenderElement(parent) => MultiChildRenderElement(this, parent);

  @override
  rad.DomTagType? get correspondingTag => null;

  @override
  bool shouldUpdateWidget(covariant MultiChildWidget oldWidget) {
    return oldWidget.children != children &&
        (oldWidget.children.length != children.length ||
            Iterable.generate(children.length)
                .any((i) => children[i] != oldWidget.children[i]));
  }
}

/// Multi child render element.
class MultiChildRenderElement extends rad.RenderElement {
  MultiChildRenderElement(MultiChildWidget super.widget, super.parent);

  @override
  List<rad.Widget> get widgetChildren => (widget as MultiChildWidget).children;
}
