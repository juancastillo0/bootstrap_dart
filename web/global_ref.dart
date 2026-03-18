import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';
import 'package:jaspr/jaspr.dart';

class GlobalRef<T> extends InheritedComponent {
  final T value;
  GlobalRef({required this.value, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedComponent oldComponent) {
    return true;
  }
}

extension JasprBootstrapContextGlobalRef on BootstrapBuildContext {
  T globalRef<T>() {
    final value = ctx
        .getElementForInheritedComponentOfExactType<GlobalRef<T>>();
    return (value as GlobalRef<T>) as T;
  }
}

// final Map<Type, Map<String, Object?>> _globalCtx = {};

// Component globalRef<T>(
//   String name,
//   T Function() valueBuilder,
//   List<Component> children,
// ) {
//   return fc((ctx) {
//     useEffect(() {
//       final v = valueBuilder();
//       _globalCtx.update(T, (m) => m, ifAbsent: () => {})[name] = v;
//     });

//     return Component.fragment(children);
//   });
// }
