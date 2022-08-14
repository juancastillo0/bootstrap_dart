import 'package:universal_html/html.dart' as html;

const _error = '''
You should implement a BootstrapRenderer and set the `bootstrapRenderer`
for Bootstrap Dart to render the components.
You can use one of the provided packages:
- jaspr_bootstrap
- rad_bootstrap
- deact_bootstrap
''';

class BootstrapRenderer<N> {
  N el(
    String tag, {
    Map<String, Object?>? attributes,
    Iterable<dynamic>? children,
    Object? key,
    Map<String, void Function(html.Event)>? listeners,
    Ref<html.Element?>? ref,
  }) =>
      throw _error;

  N txt(String text) => throw _error;

  N fragment(List<dynamic> children) => throw _error;

  N fc(dynamic Function(BootstrapBuildContext) builder, {Object? key}) =>
      throw _error;
}

abstract class BootstrapBuildContext {
  Ref<T> hookRef<T>(T Function() create);

  void hookEffect(
    void Function()? Function() effect, [
    List<Object?>? keys,
    bool Function(Object?, Object?)? equals,
  ]);

  State<T> hookState<T>(T Function() create);
}

BootstrapRenderer bootstrapRenderer = BootstrapRenderer();

abstract class Ref<T> {
  Ref(this.value);
  T value;
}

typedef State<T> = Ref<T>;
