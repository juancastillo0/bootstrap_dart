import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';

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

abstract class TreeStore<C, E extends Object> {
  @protected
  TreeValue<T> obs<T>(T initialValue) => TreeValue(this, initialValue);

  @protected
  TreeMap<K, V> obsMap<K, V>(ObservableMap<K, V> initialValue) =>
      TreeMap(this, initialValue);

  final Map<Object, Action> _handlers = {};

  @protected
  void on<T extends C>(void Function(T) handler) {
    _handlers[T] = Action(handler, name: T.toString());
  }

  StoreError<C, E>? consume<T extends C>(T command) {
    final handler = (_handlers[T] ?? _handlers[command.runtimeType])!;
    try {
      handler.call([command]);
      onSuccess(command);
    } on E catch (error) {
      return StoreError(command, error);
    }
  }

  void onSuccess(C command);
}

class StoreError<C, E> {
  final C command;
  final E error;

  StoreError(this.command, this.error);
}
