import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';

part 'cacho_command.g.dart';
part 'cacho_command.freezed.dart';

@GraphQLInput(oneOf: true)
class CachoCommandInput {
  final SuggestionInput? suggest;
  final bool? start;
  final bool? cazar;
  final bool? dudar;

  const CachoCommandInput({
    this.suggest,
    this.start,
    this.cazar,
    this.dudar,
  });

  CachoCommand asCommand() {
    if (suggest != null) {
      return CachoCommand.suggest(suggest!.asSuggestion());
    } else if (cazar == true) {
      return const CachoCommandCazar();
    } else if (dudar == true) {
      return const CachoCommandDudar();
    } else if (start == true) {
      return const CachoCommandStart();
    }

    throw Error();
  }

  Map<String, dynamic> toJson() {
    return {
      'suggest': suggest?.toJson(),
      'start': start,
      'cazar': cazar,
      'dudar': dudar,
    }..removeWhere((key, value) => value == null || value == false);
  }

  factory CachoCommandInput.fromJson(Map<String, dynamic> map) {
    return CachoCommandInput(
      suggest: map['suggest'] != null
          ? SuggestionInput.fromJson(map['suggest'])
          : null,
      start: map['start'],
      cazar: map['cazar'],
      dudar: map['dudar'],
    );
  }
}

@GraphQLUnion()
abstract class CachoCommand {
  const CachoCommand._();
  CachoCommandType get type;

  const factory CachoCommand.suggest(Suggestion suggestion) =
      CachoCommandSuggest;
  const factory CachoCommand.start() = CachoCommandStart;
  const factory CachoCommand.cazar() = CachoCommandCazar;
  const factory CachoCommand.dudar() = CachoCommandDudar;

  Map<String, Object?> toJson() => {'runtimeType': type.name};

  factory CachoCommand.fromJson(Map<String, Object?> json) {
    final _runtimeType = json['runtimeType'] as String? ?? json.keys.first;
    if (json['runtimeType'] == null) {
      json = json[_runtimeType] as Map<String, Object?>;
    }
    final type = CachoCommandType.values.firstWhere(
      (e) => e.name == _runtimeType,
    );
    switch (type) {
      case CachoCommandType.suggest:
        return CachoCommandSuggest.fromJson(json);
      case CachoCommandType.cazar:
        return CachoCommandCazar();
      case CachoCommandType.dudar:
        return CachoCommandDudar();
      case CachoCommandType.start:
        return CachoCommandStart();
    }
  }
}

@GraphQLEnum()
enum CachoCommandType {
  suggest,
  start,
  cazar,
  dudar,
}

@GraphQLObject()
class CachoCommandSuggest extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.suggest;
  final Suggestion suggestion;

  const CachoCommandSuggest(this.suggestion) : super._();

  Map<String, Object?> toJson() =>
      {'runtimeType': type.name, 'suggestion': suggestion.toJson()};

  factory CachoCommandSuggest.fromJson(Map<String, Object?> json) {
    return CachoCommandSuggest(
      Suggestion.fromJson(json['suggestion'] as Map<String, Object?>),
    );
  }
}

@GraphQLObject()
class CachoCommandStart extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.start;
  const CachoCommandStart() : super._();
}

@GraphQLObject()
class CachoCommandCazar extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.cazar;
  const CachoCommandCazar() : super._();
}

@GraphQLObject()
class CachoCommandDudar extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.dudar;
  const CachoCommandDudar() : super._();
}

@GraphQLInput(oneOf: true)
@freezed
class SuggestionInput with _$SuggestionInput {
  const SuggestionInput._();

  const factory SuggestionInput({
    SuggestionDices? dices,
    bool? salpicon,
  }) = _SuggestionInput;

  factory SuggestionInput.fromJson(Map<String, Object?> json) =>
      _$SuggestionInputFromJson(json);

  Suggestion asSuggestion() => dices != null
      ? dices!
      : salpicon == true
          ? const Suggestion.salpicon()
          : throw Error();
}

// TODO: static const salpicon
@GraphQLUnion()
abstract class Suggestion {
  const factory Suggestion.dices({
    required int amount,
    required int dice,
  }) = SuggestionDices;
  const factory Suggestion.salpicon() = SuggestionSalpicon;

  String get variant;

  Map<String, Object?> toJson();

  factory Suggestion.fromJson(Map<String, Object?> json) =>
      json['runtimeType'] == 'salpicon'
          ? const Suggestion.salpicon()
          : SuggestionDices.fromJson(json);
}

// TODO: implements Comparable<SuggestionDices>
@GraphQLObject()
@GraphQLInput()
class SuggestionDices implements Suggestion, Comparable<SuggestionDices> {
  final int amount;
  final int dice;

  String get variant => 'dices';

  const SuggestionDices({
    required this.amount,
    required this.dice,
  });

  @override
  int compareTo(SuggestionDices other) {
    return amount > other.amount ? 1 : dice - other.dice;
  }

  @override
  Map<String, Object?> toJson() =>
      {'runtimeType': variant, 'amount': amount, 'dice': dice};

  factory SuggestionDices.fromJson(Map<String, Object?> json) =>
      SuggestionDices(amount: json['amount'] as int, dice: json['dice'] as int);
}

@GraphQLObject()
class SuggestionSalpicon implements Suggestion {
  const SuggestionSalpicon();

  String get variant => 'salpicon';

  @override
  Map<String, Object?> toJson() => {'runtimeType': variant};
}

@GraphQLObject()
class CachoData {
  final String id;
  final int totalDices;
  final bool canCazar;
  final int? minAs;
  final int? minOther;
  final bool isPlaying;
  final int playerNumber;
  final List<String> players;
  final String? currentPlayer;
  final String? previousPlayer;
  final Suggestion? currentSuggestion;
  final SuggestionDices? currentDiceSuggestion;
  final List<int> dices;
  final List<String> salpiconedPlayers;

  const CachoData({
    required this.id,
    required this.totalDices,
    required this.canCazar,
    required this.minAs,
    required this.minOther,
    required this.isPlaying,
    required this.playerNumber,
    required this.players,
    required this.currentPlayer,
    required this.previousPlayer,
    required this.currentSuggestion,
    required this.currentDiceSuggestion,
    required this.dices,
    required this.salpiconedPlayers,
  });
}
