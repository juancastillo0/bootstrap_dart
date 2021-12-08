import 'package:async/async.dart';
import 'package:deact/deact.dart';

T useMemo<T>(
  ComponentContext ctx,
  T Function() valueFactory, [
  List<Object?> keys = const [],
  KeysEquals keysEquals = defaultKeysEquals,
]) {
  final prevKeys = usePrevious(ctx, keys);
  final ref = ctx.hookRef(valueFactory);
  if (prevKeys != null &&
      ComponentContext.areKeysDifferent(prevKeys, keys, keysEquals)) {
    ref.value = valueFactory();
  }
  return ref.value;
}

F useCallback<F extends Function>(
  ComponentContext ctx,
  F callback,
  List<Object?> keys, [
  KeysEquals keysEquals = defaultKeysEquals,
]) {
  return useMemo(ctx, () => callback, keys, keysEquals);
}

T? usePrevious<T>(ComponentContext ctx, T value) {
  final previous = ctx.hookRef<T?>(() => null);
  final toReturn = previous.value;
  previous.value = value;
  return toReturn;
}

R? useValueChanged<T, R>(
  ComponentContext ctx,
  T value,
  R? Function(T previous, R? oldResult) onChanged,
) {
  final previous = usePrevious(ctx, value);
  bool isInitial = false;
  final result = ctx.hookRef<R?>(() {
    isInitial = true;
    return null;
  });
  final newResult = useMemo(
    ctx,
    () {
      if (!isInitial && value != previous) {
        return onChanged(previous as T, result.value);
      }
      return result.value;
    },
    [previous, value],
  );
  return newResult;
}

bool Function() useIsMounted(ComponentContext ctx) {
  final isMounted = ctx.hookRef(() => false);
  ctx.hookEffect(
    () {
      isMounted.value = true;
      return () {
        isMounted.value = false;
      };
    },
    const [],
  );
  return () => isMounted.value;
}

Result<T> useStream<T>(
  ComponentContext ctx,
  Stream<T> stream, {
  required T Function() initialValue,
}) {
  final result = ctx.hookState(
    () => Result.value(initialValue()),
  );
  ctx.hookEffect(
    () {
      final subs = Result.captureStream(stream).listen((event) {
        result.value = event;
      });
      return () {
        subs.cancel();
      };
    },
    [stream],
  );
  return result.value;
}


// getCacheSignal?: () => AbortSignal,
// getCacheForType?: <T>(resourceType: () => T) => T,
// readContext<T>(context: ReactContext<T>): T,
// useState<S>(initialState: (() => S) | S): [S, Dispatch<BasicStateAction<S>>],
// useReducer<S, I, A>(
//   reducer: (S, A) => S,
//   initialArg: I,
//   init?: (I) => S,
// ): [S, Dispatch<A>],
// useContext<T>(context: ReactContext<T>): T,
// useRef<T>(initialValue: T): {|current: T|},
// useEffect(
//   create: () => (() => void) | void,
//   deps: Array<mixed> | void | null,
// ): void,
// useInsertionEffect(
//   create: () => (() => void) | void,
//   deps: Array<mixed> | void | null,
// ): void,
// useLayoutEffect(
//   create: () => (() => void) | void,
//   deps: Array<mixed> | void | null,
// ): void,
// useCallback<T>(callback: T, deps: Array<mixed> | void | null): T,
// useMemo<T>(nextCreate: () => T, deps: Array<mixed> | void | null): T,
// useImperativeHandle<T>(
//   ref: {|current: T | null|} | ((inst: T | null) => mixed) | null | void,
//   create: () => T,
//   deps: Array<mixed> | void | null,
// ): void,
// useDebugValue<T>(value: T, formatterFn: ?(value: T) => mixed): void,
// useDeferredValue<T>(value: T): T,
// useTransition(): [boolean, (() => void) => void],
// useMutableSource<Source, Snapshot>(
//   source: MutableSource<Source>,
//   getSnapshot: MutableSourceGetSnapshotFn<Source, Snapshot>,
//   subscribe: MutableSourceSubscribeFn<Source, Snapshot>,
// ): Snapshot,
// useSyncExternalStore<T>(
//   subscribe: (() => void) => () => void,
//   getSnapshot: () => T,
//   getServerSnapshot?: () => T,
// ): T,
// useId(): string,
// useCacheRefresh?: () => <T>(?() => T, ?T) => void,