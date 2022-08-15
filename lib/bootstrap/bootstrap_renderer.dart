import 'package:universal_html/html.dart' as html;

const _error = '''
You should implement a BootstrapRenderer and set the `bootstrapRenderer`
for Bootstrap Dart to render the components.
You can use one of the provided packages:
- jaspr_bootstrap
- rad_bootstrap
- deact_bootstrap
''';

// @example-start{bootstrap-renderer-interface}
/// A renderer used within the Bootstrap components to create html elements.
///
/// A "node" is in reference to a Node, Widget or Component in each of the frameworks.
class BootstrapRenderer<N> {
  /// Returns a node that renders an html element of the given [tag].
  /// The [attributes], [listeners] and [children] should be set for the html element.
  /// The [ref] should be populated when an effect using [BootstrapBuildContext.hookEffect] is run.
  N el(
    String tag, {
    Map<String, Object?>? attributes,
    Iterable<dynamic>? children,
    Object? key,
    Map<String, void Function(html.Event)>? listeners,
    Ref<html.Element?>? ref,
  }) =>
      throw _error;

  /// Returns a node that renders an html text node.
  N txt(String text) => throw _error;

  /// Returns a node that renders multiple [children] nodes.
  N fragment(List<dynamic> children) => throw _error;

  /// Returns a node that support hooks with the API in [BootstrapBuildContext].
  N fc(dynamic Function(BootstrapBuildContext) builder, {Object? key}) =>
      throw _error;
}

abstract class BootstrapBuildContext {
  /// A reference to a mutable value of type [T] associated with this context.
  /// [create] will be called only once for setting up the initial value.
  Ref<T> hookRef<T>(T Function() create);

  /// The [effect] should be called when the html elements are rendered.
  /// If any of the [keys] change, [effect] should be re-executed.
  /// If [effect] returns a function, it should be called to release resources
  /// from the executed [effect] when the keys change or the component is unmounted.
  void hookEffect(
    void Function()? Function() effect, [
    List<Object?>? keys,
    bool Function(Object?, Object?)? equals,
  ]);

  /// A reference to a mutable value of type [T] associated with this context.
  /// If changed, this should rerender the component associated with this context.
  /// [create] will be called only once for setting up the initial value.
  State<T> hookState<T>(T Function() create);
}

/// The renderer used within the Bootstrap components to create html elements.
///
/// You should set the `bootstrapRenderer` for Bootstrap Dart to render the components.
/// You can use one of the provided packages:
/// - jaspr_bootstrap
/// - rad_bootstrap
/// - deact_bootstrap
BootstrapRenderer bootstrapRenderer = BootstrapRenderer();

/// A reference to a mutable [value] of type [T].
abstract class Ref<T> {
  Ref(this.value);
  T value;
}

/// A reference to a mutable [value] of type [T].
/// If changed, this should rerender the component in which this was created.
typedef State<T> = Ref<T>;
// @example-end{bootstrap-renderer-interface}
