import 'package:rad/rad.dart';
import 'package:rad_hooks/rad_hooks.dart' as rad_hooks;

typedef NullableVoidCallback = VoidCallback? Function();

/// [rad_hooks.useEffect] with custom dependency diffing.
///
void useCustomEffect<T>(
  NullableVoidCallback effectCallback, [
  List<T>? dependencies,
  bool Function(Object? p1, Object? p2)? equals,
]) {
  var isInitialRenderRef = rad_hooks.useRef(true);
  var dependenciesRef = rad_hooks.useRef(dependencies);
  var cleanupCallbackRef = rad_hooks.useRef<VoidCallback?>(null);

  rad_hooks.useEffect(() {
    // if initial render, run callback
    if (isInitialRenderRef.value) {
      isInitialRenderRef.value = false;
      cleanupCallbackRef.value = effectCallback();

      return null;
    }

    // for subsequent renders, run callback only if dependencies have changed.
    if (_isAnyDependencyChanged(
      equals: equals,
      dependenciesSetOne: dependenciesRef.value,
      dependenciesSetTwo: dependencies,
    )) {
      dependenciesRef.value = dependencies;

      cleanupCallbackRef.value?.call();
      cleanupCallbackRef.value = effectCallback();
    }

    return null;
  }, null); // null ensures that this useEffect runs on every render.

  // this useEffect will ensure that cleanup callback(if any) gets dispatched when scope unmounts
  rad_hooks.useEffect(() => () => cleanupCallbackRef.value?.call(), const []);
}

/// We consider dependency sets to be different:
///
/// - if one/both sets are null.
/// - if sets are of different lengths.
/// - if [equals] return false for an item(during pair-wise comparison).
///
bool _isAnyDependencyChanged<T>({
  bool Function(Object? p1, Object? p2)? equals,
  required List<T>? dependenciesSetOne,
  required List<T>? dependenciesSetTwo,
}) {
  if (null == dependenciesSetOne || null == dependenciesSetTwo) {
    return true;
  }

  if (dependenciesSetOne == dependenciesSetTwo) {
    return false;
  }

  if (dependenciesSetOne.length != dependenciesSetTwo.length) {
    return true;
  }

  var index = 0;
  var keyEquals = equals ?? (Object? p1, Object? p2) => p1 == p2;
  return dependenciesSetOne.any((element) {
    return !keyEquals(element, dependenciesSetTwo.elementAt(index++));
  });
}
