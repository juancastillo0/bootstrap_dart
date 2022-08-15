// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'continental_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContinentalComm _$ContinentalCommFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'start':
      return ContinentalCommStart.fromJson(json);
    case 'addPlayer':
      return ContinentalCommAddPlayer.fromJson(json);
    case 'comer':
      return ContinentalCommComer.fromJson(json);
    case 'bajar':
      return ContinentalCommBajar.fromJson(json);
    case 'castigarse':
      return ContinentalCommCastigarse.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ContinentalComm',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ContinentalComm {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function(String playerId) addPlayer,
    required TResult Function(bool fromDropped) comer,
    required TResult Function(CardSet cardSet) bajar,
    required TResult Function(String playerId) castigarse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContinentalCommStart value) start,
    required TResult Function(ContinentalCommAddPlayer value) addPlayer,
    required TResult Function(ContinentalCommComer value) comer,
    required TResult Function(ContinentalCommBajar value) bajar,
    required TResult Function(ContinentalCommCastigarse value) castigarse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContinentalCommCopyWith<$Res> {
  factory $ContinentalCommCopyWith(
          ContinentalComm value, $Res Function(ContinentalComm) then) =
      _$ContinentalCommCopyWithImpl<$Res>;
}

/// @nodoc
class _$ContinentalCommCopyWithImpl<$Res>
    implements $ContinentalCommCopyWith<$Res> {
  _$ContinentalCommCopyWithImpl(this._value, this._then);

  final ContinentalComm _value;
  // ignore: unused_field
  final $Res Function(ContinentalComm) _then;
}

/// @nodoc
abstract class _$$ContinentalCommStartCopyWith<$Res> {
  factory _$$ContinentalCommStartCopyWith(_$ContinentalCommStart value,
          $Res Function(_$ContinentalCommStart) then) =
      __$$ContinentalCommStartCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContinentalCommStartCopyWithImpl<$Res>
    extends _$ContinentalCommCopyWithImpl<$Res>
    implements _$$ContinentalCommStartCopyWith<$Res> {
  __$$ContinentalCommStartCopyWithImpl(_$ContinentalCommStart _value,
      $Res Function(_$ContinentalCommStart) _then)
      : super(_value, (v) => _then(v as _$ContinentalCommStart));

  @override
  _$ContinentalCommStart get _value => super._value as _$ContinentalCommStart;
}

/// @nodoc
@JsonSerializable()
class _$ContinentalCommStart extends ContinentalCommStart {
  const _$ContinentalCommStart({final String? $type})
      : $type = $type ?? 'start',
        super._();

  factory _$ContinentalCommStart.fromJson(Map<String, dynamic> json) =>
      _$$ContinentalCommStartFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContinentalComm.start()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ContinentalCommStart);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function(String playerId) addPlayer,
    required TResult Function(bool fromDropped) comer,
    required TResult Function(CardSet cardSet) bajar,
    required TResult Function(String playerId) castigarse,
  }) {
    return start();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
  }) {
    return start?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContinentalCommStart value) start,
    required TResult Function(ContinentalCommAddPlayer value) addPlayer,
    required TResult Function(ContinentalCommComer value) comer,
    required TResult Function(ContinentalCommBajar value) bajar,
    required TResult Function(ContinentalCommCastigarse value) castigarse,
  }) {
    return start(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
  }) {
    return start?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinentalCommStartToJson(
      this,
    );
  }
}

abstract class ContinentalCommStart extends ContinentalComm {
  const factory ContinentalCommStart() = _$ContinentalCommStart;
  const ContinentalCommStart._() : super._();

  factory ContinentalCommStart.fromJson(Map<String, dynamic> json) =
      _$ContinentalCommStart.fromJson;
}

/// @nodoc
abstract class _$$ContinentalCommAddPlayerCopyWith<$Res> {
  factory _$$ContinentalCommAddPlayerCopyWith(_$ContinentalCommAddPlayer value,
          $Res Function(_$ContinentalCommAddPlayer) then) =
      __$$ContinentalCommAddPlayerCopyWithImpl<$Res>;
  $Res call({String playerId});
}

/// @nodoc
class __$$ContinentalCommAddPlayerCopyWithImpl<$Res>
    extends _$ContinentalCommCopyWithImpl<$Res>
    implements _$$ContinentalCommAddPlayerCopyWith<$Res> {
  __$$ContinentalCommAddPlayerCopyWithImpl(_$ContinentalCommAddPlayer _value,
      $Res Function(_$ContinentalCommAddPlayer) _then)
      : super(_value, (v) => _then(v as _$ContinentalCommAddPlayer));

  @override
  _$ContinentalCommAddPlayer get _value =>
      super._value as _$ContinentalCommAddPlayer;

  @override
  $Res call({
    Object? playerId = freezed,
  }) {
    return _then(_$ContinentalCommAddPlayer(
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinentalCommAddPlayer extends ContinentalCommAddPlayer {
  const _$ContinentalCommAddPlayer(
      {required this.playerId, final String? $type})
      : $type = $type ?? 'addPlayer',
        super._();

  factory _$ContinentalCommAddPlayer.fromJson(Map<String, dynamic> json) =>
      _$$ContinentalCommAddPlayerFromJson(json);

  @override
  final String playerId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContinentalComm.addPlayer(playerId: $playerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinentalCommAddPlayer &&
            const DeepCollectionEquality().equals(other.playerId, playerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(playerId));

  @JsonKey(ignore: true)
  @override
  _$$ContinentalCommAddPlayerCopyWith<_$ContinentalCommAddPlayer>
      get copyWith =>
          __$$ContinentalCommAddPlayerCopyWithImpl<_$ContinentalCommAddPlayer>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function(String playerId) addPlayer,
    required TResult Function(bool fromDropped) comer,
    required TResult Function(CardSet cardSet) bajar,
    required TResult Function(String playerId) castigarse,
  }) {
    return addPlayer(playerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
  }) {
    return addPlayer?.call(playerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
    required TResult orElse(),
  }) {
    if (addPlayer != null) {
      return addPlayer(playerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContinentalCommStart value) start,
    required TResult Function(ContinentalCommAddPlayer value) addPlayer,
    required TResult Function(ContinentalCommComer value) comer,
    required TResult Function(ContinentalCommBajar value) bajar,
    required TResult Function(ContinentalCommCastigarse value) castigarse,
  }) {
    return addPlayer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
  }) {
    return addPlayer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
    required TResult orElse(),
  }) {
    if (addPlayer != null) {
      return addPlayer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinentalCommAddPlayerToJson(
      this,
    );
  }
}

abstract class ContinentalCommAddPlayer extends ContinentalComm {
  const factory ContinentalCommAddPlayer({required final String playerId}) =
      _$ContinentalCommAddPlayer;
  const ContinentalCommAddPlayer._() : super._();

  factory ContinentalCommAddPlayer.fromJson(Map<String, dynamic> json) =
      _$ContinentalCommAddPlayer.fromJson;

  String get playerId;
  @JsonKey(ignore: true)
  _$$ContinentalCommAddPlayerCopyWith<_$ContinentalCommAddPlayer>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContinentalCommComerCopyWith<$Res> {
  factory _$$ContinentalCommComerCopyWith(_$ContinentalCommComer value,
          $Res Function(_$ContinentalCommComer) then) =
      __$$ContinentalCommComerCopyWithImpl<$Res>;
  $Res call({bool fromDropped});
}

/// @nodoc
class __$$ContinentalCommComerCopyWithImpl<$Res>
    extends _$ContinentalCommCopyWithImpl<$Res>
    implements _$$ContinentalCommComerCopyWith<$Res> {
  __$$ContinentalCommComerCopyWithImpl(_$ContinentalCommComer _value,
      $Res Function(_$ContinentalCommComer) _then)
      : super(_value, (v) => _then(v as _$ContinentalCommComer));

  @override
  _$ContinentalCommComer get _value => super._value as _$ContinentalCommComer;

  @override
  $Res call({
    Object? fromDropped = freezed,
  }) {
    return _then(_$ContinentalCommComer(
      fromDropped: fromDropped == freezed
          ? _value.fromDropped
          : fromDropped // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinentalCommComer extends ContinentalCommComer {
  const _$ContinentalCommComer({required this.fromDropped, final String? $type})
      : $type = $type ?? 'comer',
        super._();

  factory _$ContinentalCommComer.fromJson(Map<String, dynamic> json) =>
      _$$ContinentalCommComerFromJson(json);

  @override
  final bool fromDropped;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContinentalComm.comer(fromDropped: $fromDropped)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinentalCommComer &&
            const DeepCollectionEquality()
                .equals(other.fromDropped, fromDropped));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(fromDropped));

  @JsonKey(ignore: true)
  @override
  _$$ContinentalCommComerCopyWith<_$ContinentalCommComer> get copyWith =>
      __$$ContinentalCommComerCopyWithImpl<_$ContinentalCommComer>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function(String playerId) addPlayer,
    required TResult Function(bool fromDropped) comer,
    required TResult Function(CardSet cardSet) bajar,
    required TResult Function(String playerId) castigarse,
  }) {
    return comer(fromDropped);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
  }) {
    return comer?.call(fromDropped);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
    required TResult orElse(),
  }) {
    if (comer != null) {
      return comer(fromDropped);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContinentalCommStart value) start,
    required TResult Function(ContinentalCommAddPlayer value) addPlayer,
    required TResult Function(ContinentalCommComer value) comer,
    required TResult Function(ContinentalCommBajar value) bajar,
    required TResult Function(ContinentalCommCastigarse value) castigarse,
  }) {
    return comer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
  }) {
    return comer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
    required TResult orElse(),
  }) {
    if (comer != null) {
      return comer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinentalCommComerToJson(
      this,
    );
  }
}

abstract class ContinentalCommComer extends ContinentalComm {
  const factory ContinentalCommComer({required final bool fromDropped}) =
      _$ContinentalCommComer;
  const ContinentalCommComer._() : super._();

  factory ContinentalCommComer.fromJson(Map<String, dynamic> json) =
      _$ContinentalCommComer.fromJson;

  bool get fromDropped;
  @JsonKey(ignore: true)
  _$$ContinentalCommComerCopyWith<_$ContinentalCommComer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContinentalCommBajarCopyWith<$Res> {
  factory _$$ContinentalCommBajarCopyWith(_$ContinentalCommBajar value,
          $Res Function(_$ContinentalCommBajar) then) =
      __$$ContinentalCommBajarCopyWithImpl<$Res>;
  $Res call({CardSet cardSet});
}

/// @nodoc
class __$$ContinentalCommBajarCopyWithImpl<$Res>
    extends _$ContinentalCommCopyWithImpl<$Res>
    implements _$$ContinentalCommBajarCopyWith<$Res> {
  __$$ContinentalCommBajarCopyWithImpl(_$ContinentalCommBajar _value,
      $Res Function(_$ContinentalCommBajar) _then)
      : super(_value, (v) => _then(v as _$ContinentalCommBajar));

  @override
  _$ContinentalCommBajar get _value => super._value as _$ContinentalCommBajar;

  @override
  $Res call({
    Object? cardSet = freezed,
  }) {
    return _then(_$ContinentalCommBajar(
      cardSet: cardSet == freezed
          ? _value.cardSet
          : cardSet // ignore: cast_nullable_to_non_nullable
              as CardSet,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinentalCommBajar extends ContinentalCommBajar {
  const _$ContinentalCommBajar({required this.cardSet, final String? $type})
      : $type = $type ?? 'bajar',
        super._();

  factory _$ContinentalCommBajar.fromJson(Map<String, dynamic> json) =>
      _$$ContinentalCommBajarFromJson(json);

  @override
  final CardSet cardSet;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContinentalComm.bajar(cardSet: $cardSet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinentalCommBajar &&
            const DeepCollectionEquality().equals(other.cardSet, cardSet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(cardSet));

  @JsonKey(ignore: true)
  @override
  _$$ContinentalCommBajarCopyWith<_$ContinentalCommBajar> get copyWith =>
      __$$ContinentalCommBajarCopyWithImpl<_$ContinentalCommBajar>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function(String playerId) addPlayer,
    required TResult Function(bool fromDropped) comer,
    required TResult Function(CardSet cardSet) bajar,
    required TResult Function(String playerId) castigarse,
  }) {
    return bajar(cardSet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
  }) {
    return bajar?.call(cardSet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
    required TResult orElse(),
  }) {
    if (bajar != null) {
      return bajar(cardSet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContinentalCommStart value) start,
    required TResult Function(ContinentalCommAddPlayer value) addPlayer,
    required TResult Function(ContinentalCommComer value) comer,
    required TResult Function(ContinentalCommBajar value) bajar,
    required TResult Function(ContinentalCommCastigarse value) castigarse,
  }) {
    return bajar(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
  }) {
    return bajar?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
    required TResult orElse(),
  }) {
    if (bajar != null) {
      return bajar(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinentalCommBajarToJson(
      this,
    );
  }
}

abstract class ContinentalCommBajar extends ContinentalComm {
  const factory ContinentalCommBajar({required final CardSet cardSet}) =
      _$ContinentalCommBajar;
  const ContinentalCommBajar._() : super._();

  factory ContinentalCommBajar.fromJson(Map<String, dynamic> json) =
      _$ContinentalCommBajar.fromJson;

  CardSet get cardSet;
  @JsonKey(ignore: true)
  _$$ContinentalCommBajarCopyWith<_$ContinentalCommBajar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContinentalCommCastigarseCopyWith<$Res> {
  factory _$$ContinentalCommCastigarseCopyWith(
          _$ContinentalCommCastigarse value,
          $Res Function(_$ContinentalCommCastigarse) then) =
      __$$ContinentalCommCastigarseCopyWithImpl<$Res>;
  $Res call({String playerId});
}

/// @nodoc
class __$$ContinentalCommCastigarseCopyWithImpl<$Res>
    extends _$ContinentalCommCopyWithImpl<$Res>
    implements _$$ContinentalCommCastigarseCopyWith<$Res> {
  __$$ContinentalCommCastigarseCopyWithImpl(_$ContinentalCommCastigarse _value,
      $Res Function(_$ContinentalCommCastigarse) _then)
      : super(_value, (v) => _then(v as _$ContinentalCommCastigarse));

  @override
  _$ContinentalCommCastigarse get _value =>
      super._value as _$ContinentalCommCastigarse;

  @override
  $Res call({
    Object? playerId = freezed,
  }) {
    return _then(_$ContinentalCommCastigarse(
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinentalCommCastigarse extends ContinentalCommCastigarse {
  const _$ContinentalCommCastigarse(
      {required this.playerId, final String? $type})
      : $type = $type ?? 'castigarse',
        super._();

  factory _$ContinentalCommCastigarse.fromJson(Map<String, dynamic> json) =>
      _$$ContinentalCommCastigarseFromJson(json);

  @override
  final String playerId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContinentalComm.castigarse(playerId: $playerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinentalCommCastigarse &&
            const DeepCollectionEquality().equals(other.playerId, playerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(playerId));

  @JsonKey(ignore: true)
  @override
  _$$ContinentalCommCastigarseCopyWith<_$ContinentalCommCastigarse>
      get copyWith => __$$ContinentalCommCastigarseCopyWithImpl<
          _$ContinentalCommCastigarse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function(String playerId) addPlayer,
    required TResult Function(bool fromDropped) comer,
    required TResult Function(CardSet cardSet) bajar,
    required TResult Function(String playerId) castigarse,
  }) {
    return castigarse(playerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
  }) {
    return castigarse?.call(playerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function(String playerId)? addPlayer,
    TResult Function(bool fromDropped)? comer,
    TResult Function(CardSet cardSet)? bajar,
    TResult Function(String playerId)? castigarse,
    required TResult orElse(),
  }) {
    if (castigarse != null) {
      return castigarse(playerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContinentalCommStart value) start,
    required TResult Function(ContinentalCommAddPlayer value) addPlayer,
    required TResult Function(ContinentalCommComer value) comer,
    required TResult Function(ContinentalCommBajar value) bajar,
    required TResult Function(ContinentalCommCastigarse value) castigarse,
  }) {
    return castigarse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
  }) {
    return castigarse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContinentalCommStart value)? start,
    TResult Function(ContinentalCommAddPlayer value)? addPlayer,
    TResult Function(ContinentalCommComer value)? comer,
    TResult Function(ContinentalCommBajar value)? bajar,
    TResult Function(ContinentalCommCastigarse value)? castigarse,
    required TResult orElse(),
  }) {
    if (castigarse != null) {
      return castigarse(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinentalCommCastigarseToJson(
      this,
    );
  }
}

abstract class ContinentalCommCastigarse extends ContinentalComm {
  const factory ContinentalCommCastigarse({required final String playerId}) =
      _$ContinentalCommCastigarse;
  const ContinentalCommCastigarse._() : super._();

  factory ContinentalCommCastigarse.fromJson(Map<String, dynamic> json) =
      _$ContinentalCommCastigarse.fromJson;

  String get playerId;
  @JsonKey(ignore: true)
  _$$ContinentalCommCastigarseCopyWith<_$ContinentalCommCastigarse>
      get copyWith => throw _privateConstructorUsedError;
}

ExternalCard _$ExternalCardFromJson(Map<String, dynamic> json) {
  return _ExternalCard.fromJson(json);
}

/// @nodoc
mixin _$ExternalCard {
  Card get card => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  int get tableCardsId => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExternalCardCopyWith<ExternalCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalCardCopyWith<$Res> {
  factory $ExternalCardCopyWith(
          ExternalCard value, $Res Function(ExternalCard) then) =
      _$ExternalCardCopyWithImpl<$Res>;
  $Res call({Card card, String playerId, int tableCardsId, int position});
}

/// @nodoc
class _$ExternalCardCopyWithImpl<$Res> implements $ExternalCardCopyWith<$Res> {
  _$ExternalCardCopyWithImpl(this._value, this._then);

  final ExternalCard _value;
  // ignore: unused_field
  final $Res Function(ExternalCard) _then;

  @override
  $Res call({
    Object? card = freezed,
    Object? playerId = freezed,
    Object? tableCardsId = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      card: card == freezed
          ? _value.card
          : card // ignore: cast_nullable_to_non_nullable
              as Card,
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      tableCardsId: tableCardsId == freezed
          ? _value.tableCardsId
          : tableCardsId // ignore: cast_nullable_to_non_nullable
              as int,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ExternalCardCopyWith<$Res>
    implements $ExternalCardCopyWith<$Res> {
  factory _$$_ExternalCardCopyWith(
          _$_ExternalCard value, $Res Function(_$_ExternalCard) then) =
      __$$_ExternalCardCopyWithImpl<$Res>;
  @override
  $Res call({Card card, String playerId, int tableCardsId, int position});
}

/// @nodoc
class __$$_ExternalCardCopyWithImpl<$Res>
    extends _$ExternalCardCopyWithImpl<$Res>
    implements _$$_ExternalCardCopyWith<$Res> {
  __$$_ExternalCardCopyWithImpl(
      _$_ExternalCard _value, $Res Function(_$_ExternalCard) _then)
      : super(_value, (v) => _then(v as _$_ExternalCard));

  @override
  _$_ExternalCard get _value => super._value as _$_ExternalCard;

  @override
  $Res call({
    Object? card = freezed,
    Object? playerId = freezed,
    Object? tableCardsId = freezed,
    Object? position = freezed,
  }) {
    return _then(_$_ExternalCard(
      card == freezed
          ? _value.card
          : card // ignore: cast_nullable_to_non_nullable
              as Card,
      playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      tableCardsId == freezed
          ? _value.tableCardsId
          : tableCardsId // ignore: cast_nullable_to_non_nullable
              as int,
      position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExternalCard implements _ExternalCard {
  const _$_ExternalCard(
      this.card, this.playerId, this.tableCardsId, this.position);

  factory _$_ExternalCard.fromJson(Map<String, dynamic> json) =>
      _$$_ExternalCardFromJson(json);

  @override
  final Card card;
  @override
  final String playerId;
  @override
  final int tableCardsId;
  @override
  final int position;

  @override
  String toString() {
    return 'ExternalCard(card: $card, playerId: $playerId, tableCardsId: $tableCardsId, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExternalCard &&
            const DeepCollectionEquality().equals(other.card, card) &&
            const DeepCollectionEquality().equals(other.playerId, playerId) &&
            const DeepCollectionEquality()
                .equals(other.tableCardsId, tableCardsId) &&
            const DeepCollectionEquality().equals(other.position, position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(card),
      const DeepCollectionEquality().hash(playerId),
      const DeepCollectionEquality().hash(tableCardsId),
      const DeepCollectionEquality().hash(position));

  @JsonKey(ignore: true)
  @override
  _$$_ExternalCardCopyWith<_$_ExternalCard> get copyWith =>
      __$$_ExternalCardCopyWithImpl<_$_ExternalCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExternalCardToJson(
      this,
    );
  }
}

abstract class _ExternalCard implements ExternalCard {
  const factory _ExternalCard(final Card card, final String playerId,
      final int tableCardsId, final int position) = _$_ExternalCard;

  factory _ExternalCard.fromJson(Map<String, dynamic> json) =
      _$_ExternalCard.fromJson;

  @override
  Card get card;
  @override
  String get playerId;
  @override
  int get tableCardsId;
  @override
  int get position;
  @override
  @JsonKey(ignore: true)
  _$$_ExternalCardCopyWith<_$_ExternalCard> get copyWith =>
      throw _privateConstructorUsedError;
}
