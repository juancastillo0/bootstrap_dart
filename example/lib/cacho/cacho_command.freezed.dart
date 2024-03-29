// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cacho_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SuggestionInput _$SuggestionInputFromJson(Map<String, dynamic> json) {
  return _SuggestionInput.fromJson(json);
}

/// @nodoc
mixin _$SuggestionInput {
  SuggestionDices? get dices => throw _privateConstructorUsedError;
  bool? get salpicon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuggestionInputCopyWith<SuggestionInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuggestionInputCopyWith<$Res> {
  factory $SuggestionInputCopyWith(
          SuggestionInput value, $Res Function(SuggestionInput) then) =
      _$SuggestionInputCopyWithImpl<$Res>;
  $Res call({SuggestionDices? dices, bool? salpicon});
}

/// @nodoc
class _$SuggestionInputCopyWithImpl<$Res>
    implements $SuggestionInputCopyWith<$Res> {
  _$SuggestionInputCopyWithImpl(this._value, this._then);

  final SuggestionInput _value;
  // ignore: unused_field
  final $Res Function(SuggestionInput) _then;

  @override
  $Res call({
    Object? dices = freezed,
    Object? salpicon = freezed,
  }) {
    return _then(_value.copyWith(
      dices: dices == freezed
          ? _value.dices
          : dices // ignore: cast_nullable_to_non_nullable
              as SuggestionDices?,
      salpicon: salpicon == freezed
          ? _value.salpicon
          : salpicon // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_SuggestionInputCopyWith<$Res>
    implements $SuggestionInputCopyWith<$Res> {
  factory _$$_SuggestionInputCopyWith(
          _$_SuggestionInput value, $Res Function(_$_SuggestionInput) then) =
      __$$_SuggestionInputCopyWithImpl<$Res>;
  @override
  $Res call({SuggestionDices? dices, bool? salpicon});
}

/// @nodoc
class __$$_SuggestionInputCopyWithImpl<$Res>
    extends _$SuggestionInputCopyWithImpl<$Res>
    implements _$$_SuggestionInputCopyWith<$Res> {
  __$$_SuggestionInputCopyWithImpl(
      _$_SuggestionInput _value, $Res Function(_$_SuggestionInput) _then)
      : super(_value, (v) => _then(v as _$_SuggestionInput));

  @override
  _$_SuggestionInput get _value => super._value as _$_SuggestionInput;

  @override
  $Res call({
    Object? dices = freezed,
    Object? salpicon = freezed,
  }) {
    return _then(_$_SuggestionInput(
      dices: dices == freezed
          ? _value.dices
          : dices // ignore: cast_nullable_to_non_nullable
              as SuggestionDices?,
      salpicon: salpicon == freezed
          ? _value.salpicon
          : salpicon // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SuggestionInput extends _SuggestionInput {
  const _$_SuggestionInput({this.dices, this.salpicon}) : super._();

  factory _$_SuggestionInput.fromJson(Map<String, dynamic> json) =>
      _$$_SuggestionInputFromJson(json);

  @override
  final SuggestionDices? dices;
  @override
  final bool? salpicon;

  @override
  String toString() {
    return 'SuggestionInput(dices: $dices, salpicon: $salpicon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SuggestionInput &&
            const DeepCollectionEquality().equals(other.dices, dices) &&
            const DeepCollectionEquality().equals(other.salpicon, salpicon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dices),
      const DeepCollectionEquality().hash(salpicon));

  @JsonKey(ignore: true)
  @override
  _$$_SuggestionInputCopyWith<_$_SuggestionInput> get copyWith =>
      __$$_SuggestionInputCopyWithImpl<_$_SuggestionInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SuggestionInputToJson(
      this,
    );
  }
}

abstract class _SuggestionInput extends SuggestionInput {
  const factory _SuggestionInput(
      {final SuggestionDices? dices,
      final bool? salpicon}) = _$_SuggestionInput;
  const _SuggestionInput._() : super._();

  factory _SuggestionInput.fromJson(Map<String, dynamic> json) =
      _$_SuggestionInput.fromJson;

  @override
  SuggestionDices? get dices;
  @override
  bool? get salpicon;
  @override
  @JsonKey(ignore: true)
  _$$_SuggestionInputCopyWith<_$_SuggestionInput> get copyWith =>
      throw _privateConstructorUsedError;
}
