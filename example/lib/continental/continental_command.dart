import 'package:bootstrap_dart_example/continental/continental_store.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'continental_command.g.dart';
part 'continental_command.freezed.dart';

@freezed
abstract class ContinentalComm with _$ContinentalComm {
  const ContinentalComm._();

  const factory ContinentalComm.start() = ContinentalCommStart;

  const factory ContinentalComm.addPlayer({
    required String playerId,
  }) = ContinentalCommAddPlayer;

  const factory ContinentalComm.comer({
    required bool fromDropped,
  }) = ContinentalCommComer;

  const factory ContinentalComm.bajar({
    required CardSet cardSet,
  }) = ContinentalCommBajar;

  const factory ContinentalComm.castigarse({
    required String playerId,
  }) = ContinentalCommCastigarse;

  factory ContinentalComm.fromJson(Map<String, Object?> json) =>
      _$ContinentalCommFromJson(json);
}

@JsonSerializable()
class CardSet {
  final List<List<Card>> threesomes;
  final List<List<Card>> stairs;
  final List<ExternalCard> external;
  final Card? toDrop;

  const CardSet({
    this.threesomes = const [],
    this.stairs = const [],
    this.external = const [],
    required this.toDrop,
  });

  Iterable<Card> allCards() => threesomes
      .expand((e) => e)
      .followedBy(stairs.expand((e) => e))
      .followedBy(external.map((e) => e.card))
      .followedBy([if (toDrop != null) toDrop!]);

  bool validate() {
    return threesomes.every((cards) {
          final nonJoker = cards.where((c) => c.n != CardN.joker).toList();
          return cards.length == 3 &&
              nonJoker.map((e) => e.n).toSet().length == 1 &&
              nonJoker.map((e) => e.type).toSet().length == nonJoker.length;
        }) &&
        stairs.every((cards) {
          int? p;
          for (final c in cards) {
            if (c.n != CardN.joker) {
              if (p == null || p == c.n.index - 1) {
                p = c.n.index;
              } else {
                return false;
              }
            } else if (p != null) {
              p += 1;
            }
          }
          final nonJoker = cards.where((c) => c.n != CardN.joker).toList();
          return cards.length == 4 &&
              nonJoker.map((e) => e.type).toSet().length == 1;
        });
  }

  factory CardSet.fromJson(Map<String, Object?> json) =>
      _$CardSetFromJson(json);

  Map<String, Object?> toJson() => _$CardSetToJson(this);
}

@freezed
class ExternalCard with _$ExternalCard {
  const factory ExternalCard(
    Card card,
    String playerId,
    int tableCardsId,
    int position,
  ) = _ExternalCard;

  factory ExternalCard.fromJson(Map<String, Object?> json) =>
      _$ExternalCardFromJson(json);
}

@JsonSerializable()
class Card {
  final CardN n;
  final CardType type;

  const Card(this.n, this.type);

  @override
  String toString() => 'Card(n: $n, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Card &&
        other.n == n &&
        (n == CardN.joker || other.type == type);
  }

  @override
  int get hashCode =>
      n == CardN.joker ? n.hashCode : n.hashCode ^ type.hashCode;

  factory Card.fromJson(Map<String, Object?> json) => _$CardFromJson(json);

  Map<String, Object?> toJson() => _$CardToJson(this);
}
