abstract class CachoCommand {
  CachoCommand();
  CachoCommandType get type;

  Map<String, Object?> toJson() => {'type': type.name};

  factory CachoCommand.fromJson(Map<String, Object?> json) {
    final type = CachoCommandType.values.firstWhere(
      (e) => e.name == json['type'],
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

enum CachoCommandType {
  suggest,
  start,
  cazar,
  dudar,
}

class CachoCommandSuggest extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.suggest;
  final Suggestion suggestion;

  CachoCommandSuggest(this.suggestion);

  Map<String, Object?> toJson() =>
      {'type': type.name, 'suggestion': suggestion.toJson()};

  factory CachoCommandSuggest.fromJson(Map<String, Object?> json) {
    return CachoCommandSuggest(
      Suggestion.fromJson(json['suggestion'] as Map<String, Object?>),
    );
  }
}

class CachoCommandStart extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.start;
  CachoCommandStart();
}

class CachoCommandCazar extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.cazar;
  CachoCommandCazar();
}

class CachoCommandDudar extends CachoCommand {
  @override
  CachoCommandType get type => CachoCommandType.dudar;
  CachoCommandDudar();
}

abstract class Suggestion {
  const factory Suggestion.dices({
    required int amount,
    required int dice,
  }) = SuggestionDices;
  static const salpicon = SuggestionSalpicon();

  Map<String, Object?> toJson();

  factory Suggestion.fromJson(Map<String, Object?> json) =>
      json['type'] == 'salpicon'
          ? Suggestion.salpicon
          : SuggestionDices.fromJson(json);
}

class SuggestionDices implements Suggestion, Comparable<SuggestionDices> {
  final int amount;
  final int dice;

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
      {'type': 'dices', 'amount': amount, 'dice': dice};

  factory SuggestionDices.fromJson(Map<String, Object?> json) =>
      SuggestionDices(amount: json['amount'] as int, dice: json['dice'] as int);
}

class SuggestionSalpicon implements Suggestion {
  const SuggestionSalpicon();

  @override
  Map<String, Object?> toJson() => {'type': 'salpicon'};
}
