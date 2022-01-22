import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

class Action1<T, O> {
  final Action action;

  Action1(
    String name,
    O Function(T) execute,
  ) : action = Action(execute, name: name);

  O call(T arg1) => action([arg1]);
}

class TreeValue<T> {
  final TreeStore store;
  TreeValue(this.store, T initialValue) : _state = Observable(initialValue);

  final Observable<T> _state;

  T get value => _state.value;
  set value(T newValue) {
    _state.value = newValue;
  }

  set(T newValue) {
    value = newValue;
  }
}

class TreeMap<K, V> {
  final TreeStore store;
  final ObservableMap<K, V> map;

  TreeMap(this.store, this.map);
}

abstract class TreeStore<C extends Object, E extends Object> {
  @protected
  TreeValue<T> obs<T>(T initialValue) => TreeValue(this, initialValue);

  @protected
  TreeMap<K, V> obsMap<K, V>(ObservableMap<K, V> initialValue) =>
      TreeMap(this, initialValue);

  final Map<_Type, Action> _handlers = {};

  @protected
  void on<T extends C>(void Function(T) handler) {
    _handlers[_Type<T>()] = Action(handler, name: T.toString());
  }

  StoreError<C, E>? consume<T extends C>(T command) {
    final handler = _handlers[_Type<T>()] ??
        _handlers.entries.firstWhere((e) => e.key.isValue(command)).value;
    try {
      handler.call([command]);
      onSuccess(command);
    } on E catch (error, stackTrace) {
      return StoreError(command, error, stackTrace);
    }
  }

  void onSuccess(C command);
}

class _Type<T> {
  Type get type => T;

  _Type();
  bool isValue(Object o) => o is T;
  bool isType<V>() => V == T;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _Type<T> && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;
}

class StoreError<C, E> {
  final C command;
  final E error;
  final StackTrace stackTrace;

  StoreError(
    this.command,
    this.error,
    this.stackTrace,
  );
}
