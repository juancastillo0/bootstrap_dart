// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'api.graphql.g.dart';

mixin AllStateMixin {
  late String id;
  late int totalDices;
  late bool canCazar;
  int? minAs;
  int? minOther;
  late bool isPlaying;
  late int playerNumber;
  late List<String> players;
  String? currentPlayer;
  String? previousPlayer;
  AllStateMixin$Suggestion? currentSuggestion;
  AllStateMixin$SuggestionDices? currentDiceSuggestion;
  late List<int> dices;
  late List<String> salpiconedPlayers;
}

@JsonSerializable(explicitToJson: true)
class SendCachoCommand$Mutation$ResultCachoDataReqStringReq$CachoData
    extends JsonSerializable with EquatableMixin, AllStateMixin {
  SendCachoCommand$Mutation$ResultCachoDataReqStringReq$CachoData();

  factory SendCachoCommand$Mutation$ResultCachoDataReqStringReq$CachoData.fromJson(
          Map<String, dynamic> json) =>
      _$SendCachoCommand$Mutation$ResultCachoDataReqStringReq$CachoDataFromJson(
          json);

  @override
  List<Object?> get props => [
        id,
        totalDices,
        canCazar,
        minAs,
        minOther,
        isPlaying,
        playerNumber,
        players,
        currentPlayer,
        previousPlayer,
        currentSuggestion,
        currentDiceSuggestion,
        dices,
        salpiconedPlayers
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$SendCachoCommand$Mutation$ResultCachoDataReqStringReq$CachoDataToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class SendCachoCommand$Mutation$ResultCachoDataReqStringReq
    extends JsonSerializable with EquatableMixin {
  SendCachoCommand$Mutation$ResultCachoDataReqStringReq();

  factory SendCachoCommand$Mutation$ResultCachoDataReqStringReq.fromJson(
          Map<String, dynamic> json) =>
      _$SendCachoCommand$Mutation$ResultCachoDataReqStringReqFromJson(json);

  SendCachoCommand$Mutation$ResultCachoDataReqStringReq$CachoData? ok;

  String? err;

  late bool isOk;

  @override
  List<Object?> get props => [ok, err, isOk];
  @override
  Map<String, dynamic> toJson() =>
      _$SendCachoCommand$Mutation$ResultCachoDataReqStringReqToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendCachoCommand$Mutation extends JsonSerializable with EquatableMixin {
  SendCachoCommand$Mutation();

  factory SendCachoCommand$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SendCachoCommand$MutationFromJson(json);

  late SendCachoCommand$Mutation$ResultCachoDataReqStringReq sendCachoCommand;

  @override
  List<Object?> get props => [sendCachoCommand];
  @override
  Map<String, dynamic> toJson() => _$SendCachoCommand$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllStateMixin$Suggestion$SuggestionDices extends AllStateMixin$Suggestion
    with EquatableMixin {
  AllStateMixin$Suggestion$SuggestionDices();

  factory AllStateMixin$Suggestion$SuggestionDices.fromJson(
          Map<String, dynamic> json) =>
      _$AllStateMixin$Suggestion$SuggestionDicesFromJson(json);

  late int amount;

  late int dice;

  @override
  List<Object?> get props => [amount, dice];
  @override
  Map<String, dynamic> toJson() =>
      _$AllStateMixin$Suggestion$SuggestionDicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllStateMixin$Suggestion extends JsonSerializable with EquatableMixin {
  AllStateMixin$Suggestion();

  factory AllStateMixin$Suggestion.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'SuggestionDices':
        return AllStateMixin$Suggestion$SuggestionDices.fromJson(json);
      default:
    }
    return _$AllStateMixin$SuggestionFromJson(json);
  }

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [$$typename];
  @override
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'SuggestionDices':
        return (this as AllStateMixin$Suggestion$SuggestionDices).toJson();
      default:
    }
    return _$AllStateMixin$SuggestionToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class AllStateMixin$SuggestionDices extends JsonSerializable
    with EquatableMixin {
  AllStateMixin$SuggestionDices();

  factory AllStateMixin$SuggestionDices.fromJson(Map<String, dynamic> json) =>
      _$AllStateMixin$SuggestionDicesFromJson(json);

  late int amount;

  late int dice;

  @override
  List<Object?> get props => [amount, dice];
  @override
  Map<String, dynamic> toJson() => _$AllStateMixin$SuggestionDicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CachoCommandInput extends JsonSerializable with EquatableMixin {
  CachoCommandInput({this.suggest, this.start, this.cazar, this.dudar});

  factory CachoCommandInput.fromJson(Map<String, dynamic> json) =>
      _$CachoCommandInputFromJson(json);

  SuggestionInput? suggest;

  bool? start;

  bool? cazar;

  bool? dudar;

  @override
  List<Object?> get props => [suggest, start, cazar, dudar];
  @override
  Map<String, dynamic> toJson() => _$CachoCommandInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SuggestionInput extends JsonSerializable with EquatableMixin {
  SuggestionInput({this.dices, this.salpicon});

  factory SuggestionInput.fromJson(Map<String, dynamic> json) =>
      _$SuggestionInputFromJson(json);

  SuggestionDicesInput? dices;

  bool? salpicon;

  @override
  List<Object?> get props => [dices, salpicon];
  @override
  Map<String, dynamic> toJson() => _$SuggestionInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SuggestionDicesInput extends JsonSerializable with EquatableMixin {
  SuggestionDicesInput({required this.amount, required this.dice});

  factory SuggestionDicesInput.fromJson(Map<String, dynamic> json) =>
      _$SuggestionDicesInputFromJson(json);

  late int amount;

  late int dice;

  @override
  List<Object?> get props => [amount, dice];
  @override
  Map<String, dynamic> toJson() => _$SuggestionDicesInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateCacho$Mutation$CachoData extends JsonSerializable
    with EquatableMixin, AllStateMixin {
  CreateCacho$Mutation$CachoData();

  factory CreateCacho$Mutation$CachoData.fromJson(Map<String, dynamic> json) =>
      _$CreateCacho$Mutation$CachoDataFromJson(json);

  @override
  List<Object?> get props => [
        id,
        totalDices,
        canCazar,
        minAs,
        minOther,
        isPlaying,
        playerNumber,
        players,
        currentPlayer,
        previousPlayer,
        currentSuggestion,
        currentDiceSuggestion,
        dices,
        salpiconedPlayers
      ];
  @override
  Map<String, dynamic> toJson() => _$CreateCacho$Mutation$CachoDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateCacho$Mutation extends JsonSerializable with EquatableMixin {
  CreateCacho$Mutation();

  factory CreateCacho$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateCacho$MutationFromJson(json);

  late CreateCacho$Mutation$CachoData createCacho;

  @override
  List<Object?> get props => [createCacho];
  @override
  Map<String, dynamic> toJson() => _$CreateCacho$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CachoState$Subscription$CachoData extends JsonSerializable
    with EquatableMixin, AllStateMixin {
  CachoState$Subscription$CachoData();

  factory CachoState$Subscription$CachoData.fromJson(
          Map<String, dynamic> json) =>
      _$CachoState$Subscription$CachoDataFromJson(json);

  @override
  List<Object?> get props => [
        id,
        totalDices,
        canCazar,
        minAs,
        minOther,
        isPlaying,
        playerNumber,
        players,
        currentPlayer,
        previousPlayer,
        currentSuggestion,
        currentDiceSuggestion,
        dices,
        salpiconedPlayers
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$CachoState$Subscription$CachoDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CachoState$Subscription extends JsonSerializable with EquatableMixin {
  CachoState$Subscription();

  factory CachoState$Subscription.fromJson(Map<String, dynamic> json) =>
      _$CachoState$SubscriptionFromJson(json);

  late CachoState$Subscription$CachoData cachoState;

  @override
  List<Object?> get props => [cachoState];
  @override
  Map<String, dynamic> toJson() => _$CachoState$SubscriptionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendCachoCommandArguments extends JsonSerializable with EquatableMixin {
  SendCachoCommandArguments({required this.gameId, required this.command});

  @override
  factory SendCachoCommandArguments.fromJson(Map<String, dynamic> json) =>
      _$SendCachoCommandArgumentsFromJson(json);

  late String gameId;

  late CachoCommandInput command;

  @override
  List<Object?> get props => [gameId, command];
  @override
  Map<String, dynamic> toJson() => _$SendCachoCommandArgumentsToJson(this);
}

final SEND_CACHO_COMMAND_MUTATION_DOCUMENT_OPERATION_NAME = 'sendCachoCommand';
final SEND_CACHO_COMMAND_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'sendCachoCommand'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'gameId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'command')),
            type: NamedTypeNode(
                name: NameNode(value: 'CachoCommandInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'sendCachoCommand'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'gameId'),
                  value: VariableNode(name: NameNode(value: 'gameId'))),
              ArgumentNode(
                  name: NameNode(value: 'command'),
                  value: VariableNode(name: NameNode(value: 'command')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'ok'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'AllState'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'err'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'isOk'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'AllState'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'CachoData'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'totalDices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'canCazar'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'minAs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'minOther'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'isPlaying'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'playerNumber'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'players'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'currentPlayer'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'previousPlayer'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'currentSuggestion'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              InlineFragmentNode(
                  typeCondition: TypeConditionNode(
                      on: NamedTypeNode(
                          name: NameNode(value: 'SuggestionDices'),
                          isNonNull: false)),
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'amount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'dice'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'currentDiceSuggestion'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'amount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'dice'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'dices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'salpiconedPlayers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class SendCachoCommandMutation
    extends GraphQLQuery<SendCachoCommand$Mutation, SendCachoCommandArguments> {
  SendCachoCommandMutation({required this.variables});

  @override
  final DocumentNode document = SEND_CACHO_COMMAND_MUTATION_DOCUMENT;

  @override
  final String operationName =
      SEND_CACHO_COMMAND_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final SendCachoCommandArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SendCachoCommand$Mutation parse(Map<String, dynamic> json) =>
      SendCachoCommand$Mutation.fromJson(json);
}

final CREATE_CACHO_MUTATION_DOCUMENT_OPERATION_NAME = 'createCacho';
final CREATE_CACHO_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createCacho'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createCacho'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'AllState'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'AllState'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'CachoData'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'totalDices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'canCazar'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'minAs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'minOther'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'isPlaying'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'playerNumber'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'players'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'currentPlayer'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'previousPlayer'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'currentSuggestion'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              InlineFragmentNode(
                  typeCondition: TypeConditionNode(
                      on: NamedTypeNode(
                          name: NameNode(value: 'SuggestionDices'),
                          isNonNull: false)),
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'amount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'dice'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'currentDiceSuggestion'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'amount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'dice'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'dices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'salpiconedPlayers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateCachoMutation
    extends GraphQLQuery<CreateCacho$Mutation, JsonSerializable> {
  CreateCachoMutation();

  @override
  final DocumentNode document = CREATE_CACHO_MUTATION_DOCUMENT;

  @override
  final String operationName = CREATE_CACHO_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  CreateCacho$Mutation parse(Map<String, dynamic> json) =>
      CreateCacho$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CachoStateArguments extends JsonSerializable with EquatableMixin {
  CachoStateArguments({required this.gameId});

  @override
  factory CachoStateArguments.fromJson(Map<String, dynamic> json) =>
      _$CachoStateArgumentsFromJson(json);

  late String gameId;

  @override
  List<Object?> get props => [gameId];
  @override
  Map<String, dynamic> toJson() => _$CachoStateArgumentsToJson(this);
}

final CACHO_STATE_SUBSCRIPTION_DOCUMENT_OPERATION_NAME = 'cachoState';
final CACHO_STATE_SUBSCRIPTION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'cachoState'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'gameId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'cachoState'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'gameId'),
                  value: VariableNode(name: NameNode(value: 'gameId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'AllState'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'AllState'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'CachoData'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'totalDices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'canCazar'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'minAs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'minOther'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'isPlaying'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'playerNumber'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'players'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'currentPlayer'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'previousPlayer'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'currentSuggestion'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              InlineFragmentNode(
                  typeCondition: TypeConditionNode(
                      on: NamedTypeNode(
                          name: NameNode(value: 'SuggestionDices'),
                          isNonNull: false)),
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'amount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'dice'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'currentDiceSuggestion'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'amount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'dice'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'dices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'salpiconedPlayers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CachoStateSubscription
    extends GraphQLQuery<CachoState$Subscription, CachoStateArguments> {
  CachoStateSubscription({required this.variables});

  @override
  final DocumentNode document = CACHO_STATE_SUBSCRIPTION_DOCUMENT;

  @override
  final String operationName = CACHO_STATE_SUBSCRIPTION_DOCUMENT_OPERATION_NAME;

  @override
  final CachoStateArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CachoState$Subscription parse(Map<String, dynamic> json) =>
      CachoState$Subscription.fromJson(json);
}
