// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continental_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardSet _$CardSetFromJson(Map<String, dynamic> json) => CardSet(
      threesomes: (json['threesomes'] as List<dynamic>?)
              ?.map((e) => (e as List<dynamic>)
                  .map((e) => Card.fromJson(e as Map<String, dynamic>))
                  .toList())
              .toList() ??
          const [],
      stairs: (json['stairs'] as List<dynamic>?)
              ?.map((e) => (e as List<dynamic>)
                  .map((e) => Card.fromJson(e as Map<String, dynamic>))
                  .toList())
              .toList() ??
          const [],
      external: (json['external'] as List<dynamic>?)
              ?.map((e) => ExternalCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      toDrop: json['toDrop'] == null
          ? null
          : Card.fromJson(json['toDrop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardSetToJson(CardSet instance) => <String, dynamic>{
      'threesomes': instance.threesomes,
      'stairs': instance.stairs,
      'external': instance.external,
      'toDrop': instance.toDrop,
    };

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      $enumDecode(_$CardNEnumMap, json['n']),
      $enumDecode(_$CardTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'n': _$CardNEnumMap[instance.n],
      'type': _$CardTypeEnumMap[instance.type],
    };

const _$CardNEnumMap = {
  CardN.one: 'one',
  CardN.two: 'two',
  CardN.three: 'three',
  CardN.four: 'four',
  CardN.five: 'five',
  CardN.six: 'six',
  CardN.seven: 'seven',
  CardN.eight: 'eight',
  CardN.nine: 'nine',
  CardN.ten: 'ten',
  CardN.j: 'j',
  CardN.q: 'q',
  CardN.k: 'k',
  CardN.joker: 'joker',
};

const _$CardTypeEnumMap = {
  CardType.heart: 'heart',
  CardType.diamond: 'diamond',
  CardType.spade: 'spade',
  CardType.club: 'club',
};

_$ContinentalCommStart _$$ContinentalCommStartFromJson(
        Map<String, dynamic> json) =>
    _$ContinentalCommStart();

Map<String, dynamic> _$$ContinentalCommStartToJson(
        _$ContinentalCommStart instance) =>
    <String, dynamic>{};

_$ContinentalCommAddPlayer _$$ContinentalCommAddPlayerFromJson(
        Map<String, dynamic> json) =>
    _$ContinentalCommAddPlayer(
      playerId: json['playerId'] as String,
    );

Map<String, dynamic> _$$ContinentalCommAddPlayerToJson(
        _$ContinentalCommAddPlayer instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
    };

_$ContinentalCommComer _$$ContinentalCommComerFromJson(
        Map<String, dynamic> json) =>
    _$ContinentalCommComer(
      fromDropped: json['fromDropped'] as bool,
    );

Map<String, dynamic> _$$ContinentalCommComerToJson(
        _$ContinentalCommComer instance) =>
    <String, dynamic>{
      'fromDropped': instance.fromDropped,
    };

_$ContinentalCommBajar _$$ContinentalCommBajarFromJson(
        Map<String, dynamic> json) =>
    _$ContinentalCommBajar(
      cardSet: CardSet.fromJson(json['cardSet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ContinentalCommBajarToJson(
        _$ContinentalCommBajar instance) =>
    <String, dynamic>{
      'cardSet': instance.cardSet,
    };

_$ContinentalCommCastigarse _$$ContinentalCommCastigarseFromJson(
        Map<String, dynamic> json) =>
    _$ContinentalCommCastigarse(
      playerId: json['playerId'] as String,
    );

Map<String, dynamic> _$$ContinentalCommCastigarseToJson(
        _$ContinentalCommCastigarse instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
    };

_$_ExternalCard _$$_ExternalCardFromJson(Map<String, dynamic> json) =>
    _$_ExternalCard(
      Card.fromJson(json['card'] as Map<String, dynamic>),
      json['playerId'] as String,
      json['tableCardsId'] as int,
      json['position'] as int,
    );

Map<String, dynamic> _$$_ExternalCardToJson(_$_ExternalCard instance) =>
    <String, dynamic>{
      'card': instance.card,
      'playerId': instance.playerId,
      'tableCardsId': instance.tableCardsId,
      'position': instance.position,
    };
