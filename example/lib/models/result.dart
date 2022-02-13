// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:leto_schema/leto_schema.dart';

// part 'result.freezed.dart';
// part 'result.g.dart';

// @GraphQLUnion()
// @freezed
// class Result<T, E> with _$Result {
//   const Result._();
//   const factory Result.ok(T value) = Ok;
//   const factory Result.err(E value) = Err;
// }

import 'package:leto_schema/leto_schema.dart';

part 'result.g.dart';

@GraphQLClass(omitFields: true)
abstract class Result<T extends Object, E extends Object> {
  const Result._();
  @GraphQLField()
  T? get ok;
  @GraphQLField()
  E? get err;
  @GraphQLField()
  bool get isOk => ok != null;

  bool get isErr => err != null;

  const factory Result.ok(T ok) = Ok;
  const factory Result.err(E err) = Err;

  O when<O>({
    required O Function(T) ok,
    required O Function(E) err,
  }) {
    if (isOk) return ok(this.ok!);
    return err(this.err!);
  }

  O? whenOrNull<O>({
    O? Function(T)? ok,
    O? Function(E)? err,
  }) {
    if (isOk) return ok?.call(this.ok!);
    return err?.call(this.err!);
  }

  O match<O>(
    O Function(T) ok,
    O Function(E) err,
  ) {
    if (isOk) return ok(this.ok!);
    return err(this.err!);
  }

  Result<O, E> mapOk<O extends Object>(O Function(T) whenOk) =>
      isOk ? Ok(whenOk(this.ok!)) : Err(this.err!);
  Result<T, O> mapErr<O extends Object>(O Function(E) whenErr) =>
      isOk ? Ok(this.ok!) : Err(whenErr(this.err!));

  T unwrap() => isOk ? this.ok! : throw UnwrapError(this);
  T expect(String error) => isOk ? this.ok! : throw error;
  E unwrapErr() => isOk ? throw UnwrapError(this) : this.err!;
  T unwrapOr(T or) => this.ok ?? or;
  T unwrapOrElse(T Function(E) orElse) => isOk ? this.ok! : orElse(this.err!);
}

class UnwrapError<T extends Object, E extends Object> {
  final Result<T, E> result;

  UnwrapError(this.result);
}

class Ok<T extends Object, E extends Object> extends Result<T, E> {
  const Ok(this.ok) : super._();
  final T ok;
  Null get err => null;
}

class Err<T extends Object, E extends Object> extends Result<T, E> {
  const Err(this.err) : super._();
  final E err;
  Null get ok => null;
}
