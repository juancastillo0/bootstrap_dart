import 'package:bootstrap_dart/bootstrap/jaspr_renderer.dart';
import 'package:bootstrap_dart/mobx_hooks/obs.dart';
import 'package:universal_web/web.dart' as web;
import 'package:jaspr/jaspr.dart' as jaspr;

export 'package:bootstrap_dart/mobx_hooks/obs.dart' show Obs;

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
    Map<String, String>? attributes,
    Iterable<N>? children,
    Object? key,
    Map<String, void Function(web.Event)>? listeners,
    Ref<web.Element?>? ref,
  }) => throw _error;

  /// Returns a node that renders an html text node.
  N txt(String text) => throw _error;

  /// Returns a node that renders multiple [children] nodes.
  N fragment(List<N> children) => throw _error;

  /// Returns a node that support hooks with the API in [BootstrapBuildContext].
  N fc(N Function(BootstrapBuildContext) builder, {Object? key}) =>
      throw _error;
}

abstract class BootstrapBuildContext {
  /// The [jaspr.BuildContext] associated with this context.
  jaspr.BuildContext get ctx;

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
  Obs<T> hookState<T>(T Function() create);
}

/// The renderer used within the Bootstrap components to create html elements.
///
/// You should set the `bootstrapRenderer` for Bootstrap Dart to render the components.
/// You can use one of the provided packages:
/// - jaspr_bootstrap
/// - rad_bootstrap
/// - deact_bootstrap
BootstrapRenderer<jaspr.Component> bootstrapRenderer =
    const JasprBootstrapRenderer();

/// A reference to a mutable [value] of type [T].

class Ref<T> {
  Ref(this.value);
  T value;

  @override
  String toString() {
    return 'Ref($value)';
  }
}

// @example-end{bootstrap-renderer-interface}
