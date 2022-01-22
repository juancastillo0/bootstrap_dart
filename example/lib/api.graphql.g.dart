// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCachoCommand$Mutation _$SendCachoCommand$MutationFromJson(
        Map<String, dynamic> json) =>
    SendCachoCommand$Mutation()
      ..sendCachoCommand = json['sendCachoCommand'] as String?;

Map<String, dynamic> _$SendCachoCommand$MutationToJson(
        SendCachoCommand$Mutation instance) =>
    <String, dynamic>{
      'sendCachoCommand': instance.sendCachoCommand,
    };

AllStateMixin$Suggestion$SuggestionDices
    _$AllStateMixin$Suggestion$SuggestionDicesFromJson(
            Map<String, dynamic> json) =>
        AllStateMixin$Suggestion$SuggestionDices()
          ..$$typename = json['__typename'] as String?
          ..amount = json['amount'] as int
          ..dice = json['dice'] as int;

Map<String, dynamic> _$AllStateMixin$Suggestion$SuggestionDicesToJson(
        AllStateMixin$Suggestion$SuggestionDices instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'amount': instance.amount,
      'dice': instance.dice,
    };

AllStateMixin$Suggestion _$AllStateMixin$SuggestionFromJson(
        Map<String, dynamic> json) =>
    AllStateMixin$Suggestion()..$$typename = json['__typename'] as String?;

Map<String, dynamic> _$AllStateMixin$SuggestionToJson(
        AllStateMixin$Suggestion instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
    };

AllStateMixin$SuggestionDices _$AllStateMixin$SuggestionDicesFromJson(
        Map<String, dynamic> json) =>
    AllStateMixin$SuggestionDices()
      ..amount = json['amount'] as int
      ..dice = json['dice'] as int;

Map<String, dynamic> _$AllStateMixin$SuggestionDicesToJson(
        AllStateMixin$SuggestionDices instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'dice': instance.dice,
    };

CachoCommandInput _$CachoCommandInputFromJson(Map<String, dynamic> json) =>
    CachoCommandInput(
      suggest: json['suggest'] == null
          ? null
          : SuggestionInput.fromJson(json['suggest'] as Map<String, dynamic>),
      start: json['start'] as bool?,
      cazar: json['cazar'] as bool?,
      dudar: json['dudar'] as bool?,
    );

Map<String, dynamic> _$CachoCommandInputToJson(CachoCommandInput instance) =>
    <String, dynamic>{
      'suggest': instance.suggest?.toJson(),
      'start': instance.start,
      'cazar': instance.cazar,
      'dudar': instance.dudar,
    };

SuggestionInput _$SuggestionInputFromJson(Map<String, dynamic> json) =>
    SuggestionInput(
      dices: json['dices'] == null
          ? null
          : SuggestionDicesInput.fromJson(
              json['dices'] as Map<String, dynamic>),
      salpicon: json['salpicon'] as bool?,
    );

Map<String, dynamic> _$SuggestionInputToJson(SuggestionInput instance) =>
    <String, dynamic>{
      'dices': instance.dices?.toJson(),
      'salpicon': instance.salpicon,
    };

SuggestionDicesInput _$SuggestionDicesInputFromJson(
        Map<String, dynamic> json) =>
    SuggestionDicesInput(
      amount: json['amount'] as int,
      dice: json['dice'] as int,
    );

Map<String, dynamic> _$SuggestionDicesInputToJson(
        SuggestionDicesInput instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'dice': instance.dice,
    };

CreateCacho$Mutation$CachoData _$CreateCacho$Mutation$CachoDataFromJson(
        Map<String, dynamic> json) =>
    CreateCacho$Mutation$CachoData()
      ..id = json['id'] as String
      ..totalDices = json['totalDices'] as int
      ..canCazar = json['canCazar'] as bool
      ..minAs = json['minAs'] as int?
      ..minOther = json['minOther'] as int?
      ..isPlaying = json['isPlaying'] as bool
      ..playerNumber = json['playerNumber'] as int
      ..players =
          (json['players'] as List<dynamic>).map((e) => e as String).toList()
      ..currentPlayer = json['currentPlayer'] as String?
      ..previousPlayer = json['previousPlayer'] as String?
      ..currentSuggestion = json['currentSuggestion'] == null
          ? null
          : AllStateMixin$Suggestion.fromJson(
              json['currentSuggestion'] as Map<String, dynamic>)
      ..currentDiceSuggestion = json['currentDiceSuggestion'] == null
          ? null
          : AllStateMixin$SuggestionDices.fromJson(
              json['currentDiceSuggestion'] as Map<String, dynamic>)
      ..dices = (json['dices'] as List<dynamic>).map((e) => e as int).toList()
      ..salpiconedPlayers = (json['salpiconedPlayers'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$CreateCacho$Mutation$CachoDataToJson(
        CreateCacho$Mutation$CachoData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalDices': instance.totalDices,
      'canCazar': instance.canCazar,
      'minAs': instance.minAs,
      'minOther': instance.minOther,
      'isPlaying': instance.isPlaying,
      'playerNumber': instance.playerNumber,
      'players': instance.players,
      'currentPlayer': instance.currentPlayer,
      'previousPlayer': instance.previousPlayer,
      'currentSuggestion': instance.currentSuggestion?.toJson(),
      'currentDiceSuggestion': instance.currentDiceSuggestion?.toJson(),
      'dices': instance.dices,
      'salpiconedPlayers': instance.salpiconedPlayers,
    };

CreateCacho$Mutation _$CreateCacho$MutationFromJson(
        Map<String, dynamic> json) =>
    CreateCacho$Mutation()
      ..createCacho = CreateCacho$Mutation$CachoData.fromJson(
          json['createCacho'] as Map<String, dynamic>);

Map<String, dynamic> _$CreateCacho$MutationToJson(
        CreateCacho$Mutation instance) =>
    <String, dynamic>{
      'createCacho': instance.createCacho.toJson(),
    };

CachoState$Subscription$CachoData _$CachoState$Subscription$CachoDataFromJson(
        Map<String, dynamic> json) =>
    CachoState$Subscription$CachoData()
      ..id = json['id'] as String
      ..totalDices = json['totalDices'] as int
      ..canCazar = json['canCazar'] as bool
      ..minAs = json['minAs'] as int?
      ..minOther = json['minOther'] as int?
      ..isPlaying = json['isPlaying'] as bool
      ..playerNumber = json['playerNumber'] as int
      ..players =
          (json['players'] as List<dynamic>).map((e) => e as String).toList()
      ..currentPlayer = json['currentPlayer'] as String?
      ..previousPlayer = json['previousPlayer'] as String?
      ..currentSuggestion = json['currentSuggestion'] == null
          ? null
          : AllStateMixin$Suggestion.fromJson(
              json['currentSuggestion'] as Map<String, dynamic>)
      ..currentDiceSuggestion = json['currentDiceSuggestion'] == null
          ? null
          : AllStateMixin$SuggestionDices.fromJson(
              json['currentDiceSuggestion'] as Map<String, dynamic>)
      ..dices = (json['dices'] as List<dynamic>).map((e) => e as int).toList()
      ..salpiconedPlayers = (json['salpiconedPlayers'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$CachoState$Subscription$CachoDataToJson(
        CachoState$Subscription$CachoData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalDices': instance.totalDices,
      'canCazar': instance.canCazar,
      'minAs': instance.minAs,
      'minOther': instance.minOther,
      'isPlaying': instance.isPlaying,
      'playerNumber': instance.playerNumber,
      'players': instance.players,
      'currentPlayer': instance.currentPlayer,
      'previousPlayer': instance.previousPlayer,
      'currentSuggestion': instance.currentSuggestion?.toJson(),
      'currentDiceSuggestion': instance.currentDiceSuggestion?.toJson(),
      'dices': instance.dices,
      'salpiconedPlayers': instance.salpiconedPlayers,
    };

CachoState$Subscription _$CachoState$SubscriptionFromJson(
        Map<String, dynamic> json) =>
    CachoState$Subscription()
      ..cachoState = CachoState$Subscription$CachoData.fromJson(
          json['cachoState'] as Map<String, dynamic>);

Map<String, dynamic> _$CachoState$SubscriptionToJson(
        CachoState$Subscription instance) =>
    <String, dynamic>{
      'cachoState': instance.cachoState.toJson(),
    };

SendCachoCommandArguments _$SendCachoCommandArgumentsFromJson(
        Map<String, dynamic> json) =>
    SendCachoCommandArguments(
      gameId: json['gameId'] as String,
      command:
          CachoCommandInput.fromJson(json['command'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendCachoCommandArgumentsToJson(
        SendCachoCommandArguments instance) =>
    <String, dynamic>{
      'gameId': instance.gameId,
      'command': instance.command.toJson(),
    };

CachoStateArguments _$CachoStateArgumentsFromJson(Map<String, dynamic> json) =>
    CachoStateArguments(
      gameId: json['gameId'] as String,
    );

Map<String, dynamic> _$CachoStateArgumentsToJson(
        CachoStateArguments instance) =>
    <String, dynamic>{
      'gameId': instance.gameId,
    };
