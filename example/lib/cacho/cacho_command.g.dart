// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cacho_command.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final cachoCommandInputSerializer = SerializerValue<CachoCommandInput>(
  key: "CachoCommandInput",
  fromJson: (ctx, json) => CachoCommandInput.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _cachoCommandInputGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<CachoCommandInput>>(
        (setValue) {
  final __name = 'CachoCommandInput';

  final __cachoCommandInputGraphQLTypeInput =
      inputObjectType<CachoCommandInput>(__name, isOneOf: true);

  setValue(__cachoCommandInputGraphQLTypeInput);
  __cachoCommandInputGraphQLTypeInput.fields.addAll(
    [
      suggestionInputGraphQLTypeInput
          .coerceToInputObject()
          .inputField('suggest'),
      graphQLBoolean.coerceToInputObject().inputField('start'),
      graphQLBoolean.coerceToInputObject().inputField('cazar'),
      graphQLBoolean.coerceToInputObject().inputField('dudar')
    ],
  );

  return __cachoCommandInputGraphQLTypeInput;
});

/// Auto-generated from [CachoCommandInput].
GraphQLInputObjectType<CachoCommandInput>
    get cachoCommandInputGraphQLTypeInput =>
        _cachoCommandInputGraphQLTypeInput.value;

final cachoCommandSerializer = SerializerValue<CachoCommand>(
  key: "CachoCommand",
  fromJson: (ctx, json) =>
      CachoCommand.fromJson(json), // _$CachoCommandFromJson,
  // toJson: (m) => _$CachoCommandToJson(m as CachoCommand),
);

/// Generated from [CachoCommand]
GraphQLUnionType<CachoCommand> get cachoCommandGraphQLType =>
    _cachoCommandGraphQLType.value;

final _cachoCommandGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<CachoCommand>>((setValue) {
  final type = GraphQLUnionType<CachoCommand>(
    'CachoCommand',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    cachoCommandSuggestGraphQLType,
    cachoCommandStartGraphQLType,
    cachoCommandCazarGraphQLType,
    cachoCommandDudarGraphQLType,
  ]);
  return type;
});

final cachoCommandSuggestSerializer = SerializerValue<CachoCommandSuggest>(
  key: "CachoCommandSuggest",
  fromJson: (ctx, json) =>
      CachoCommandSuggest.fromJson(json), // _$CachoCommandSuggestFromJson,
  // toJson: (m) => _$CachoCommandSuggestToJson(m as CachoCommandSuggest),
);
final _cachoCommandSuggestGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<CachoCommandSuggest>>((setValue) {
  final __name = 'CachoCommandSuggest';

  final __cachoCommandSuggestGraphQLType = objectType<CachoCommandSuggest>(
      __name,
      isInterface: false,
      interfaces: []);

  setValue(__cachoCommandSuggestGraphQLType);
  __cachoCommandSuggestGraphQLType.fields.addAll(
    [
      suggestionGraphQLType
          .nonNull()
          .field('suggestion', resolve: (obj, ctx) => obj.suggestion),
      cachoCommandTypeGraphQLType
          .nonNull()
          .field('type', resolve: (obj, ctx) => obj.type)
    ],
  );

  return __cachoCommandSuggestGraphQLType;
});

/// Auto-generated from [CachoCommandSuggest].
GraphQLObjectType<CachoCommandSuggest> get cachoCommandSuggestGraphQLType =>
    _cachoCommandSuggestGraphQLType.value;

final _cachoCommandStartGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<CachoCommandStart>>((setValue) {
  final __name = 'CachoCommandStart';

  final __cachoCommandStartGraphQLType =
      objectType<CachoCommandStart>(__name, isInterface: false, interfaces: []);

  setValue(__cachoCommandStartGraphQLType);
  __cachoCommandStartGraphQLType.fields.addAll(
    [
      cachoCommandTypeGraphQLType
          .nonNull()
          .field('type', resolve: (obj, ctx) => obj.type)
    ],
  );

  return __cachoCommandStartGraphQLType;
});

/// Auto-generated from [CachoCommandStart].
GraphQLObjectType<CachoCommandStart> get cachoCommandStartGraphQLType =>
    _cachoCommandStartGraphQLType.value;

final _cachoCommandCazarGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<CachoCommandCazar>>((setValue) {
  final __name = 'CachoCommandCazar';

  final __cachoCommandCazarGraphQLType =
      objectType<CachoCommandCazar>(__name, isInterface: false, interfaces: []);

  setValue(__cachoCommandCazarGraphQLType);
  __cachoCommandCazarGraphQLType.fields.addAll(
    [
      cachoCommandTypeGraphQLType
          .nonNull()
          .field('type', resolve: (obj, ctx) => obj.type)
    ],
  );

  return __cachoCommandCazarGraphQLType;
});

/// Auto-generated from [CachoCommandCazar].
GraphQLObjectType<CachoCommandCazar> get cachoCommandCazarGraphQLType =>
    _cachoCommandCazarGraphQLType.value;

final _cachoCommandDudarGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<CachoCommandDudar>>((setValue) {
  final __name = 'CachoCommandDudar';

  final __cachoCommandDudarGraphQLType =
      objectType<CachoCommandDudar>(__name, isInterface: false, interfaces: []);

  setValue(__cachoCommandDudarGraphQLType);
  __cachoCommandDudarGraphQLType.fields.addAll(
    [
      cachoCommandTypeGraphQLType
          .nonNull()
          .field('type', resolve: (obj, ctx) => obj.type)
    ],
  );

  return __cachoCommandDudarGraphQLType;
});

/// Auto-generated from [CachoCommandDudar].
GraphQLObjectType<CachoCommandDudar> get cachoCommandDudarGraphQLType =>
    _cachoCommandDudarGraphQLType.value;

final suggestionInputSerializer = SerializerValue<SuggestionInput>(
  key: "SuggestionInput",
  fromJson: (ctx, json) =>
      SuggestionInput.fromJson(json), // _$$_SuggestionInputFromJson,
  // toJson: (m) => _$$_SuggestionInputToJson(m as _$_SuggestionInput),
);
final _suggestionInputGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<SuggestionInput>>(
        (setValue) {
  final __name = 'SuggestionInput';

  final __suggestionInputGraphQLTypeInput =
      inputObjectType<SuggestionInput>(__name, isOneOf: true);

  setValue(__suggestionInputGraphQLTypeInput);
  __suggestionInputGraphQLTypeInput.fields.addAll(
    [
      suggestionDicesGraphQLTypeInput.coerceToInputObject().inputField('dices'),
      graphQLBoolean.coerceToInputObject().inputField('salpicon')
    ],
  );

  return __suggestionInputGraphQLTypeInput;
});

/// Auto-generated from [SuggestionInput].
GraphQLInputObjectType<SuggestionInput> get suggestionInputGraphQLTypeInput =>
    _suggestionInputGraphQLTypeInput.value;

final suggestionSerializer = SerializerValue<Suggestion>(
  key: "Suggestion",
  fromJson: (ctx, json) => Suggestion.fromJson(json), // _$SuggestionFromJson,
  // toJson: (m) => _$SuggestionToJson(m as Suggestion),
);

/// Generated from [Suggestion]
GraphQLUnionType<Suggestion> get suggestionGraphQLType =>
    _suggestionGraphQLType.value;

final _suggestionGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<Suggestion>>((setValue) {
  final type = GraphQLUnionType<Suggestion>(
    'Suggestion',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    suggestionDicesGraphQLType,
    suggestionSalpiconGraphQLType,
  ]);
  return type;
});

final suggestionDicesSerializer = SerializerValue<SuggestionDices>(
  key: "SuggestionDices",
  fromJson: (ctx, json) =>
      SuggestionDices.fromJson(json), // _$SuggestionDicesFromJson,
  // toJson: (m) => _$SuggestionDicesToJson(m as SuggestionDices),
);
final _suggestionDicesGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<SuggestionDices>>((setValue) {
  final __name = 'SuggestionDices';

  final __suggestionDicesGraphQLType =
      objectType<SuggestionDices>(__name, isInterface: false, interfaces: []);

  setValue(__suggestionDicesGraphQLType);
  __suggestionDicesGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('compareTo', resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.compareTo((args["other"] as SuggestionDices));
      }, inputs: [
        suggestionDicesGraphQLTypeInput.nonNull().inputField('other')
      ]),
      graphQLInt.nonNull().field('amount', resolve: (obj, ctx) => obj.amount),
      graphQLInt.nonNull().field('dice', resolve: (obj, ctx) => obj.dice)
    ],
  );

  return __suggestionDicesGraphQLType;
});

/// Auto-generated from [SuggestionDices].
GraphQLObjectType<SuggestionDices> get suggestionDicesGraphQLType =>
    _suggestionDicesGraphQLType.value;
final _suggestionDicesGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<SuggestionDices>>(
        (setValue) {
  final __name = 'SuggestionDicesInput';

  final __suggestionDicesGraphQLTypeInput =
      inputObjectType<SuggestionDices>(__name);

  setValue(__suggestionDicesGraphQLTypeInput);
  __suggestionDicesGraphQLTypeInput.fields.addAll(
    [
      graphQLInt.nonNull().coerceToInputObject().inputField('amount'),
      graphQLInt.nonNull().coerceToInputObject().inputField('dice')
    ],
  );

  return __suggestionDicesGraphQLTypeInput;
});

/// Auto-generated from [SuggestionDices].
GraphQLInputObjectType<SuggestionDices> get suggestionDicesGraphQLTypeInput =>
    _suggestionDicesGraphQLTypeInput.value;

final _suggestionSalpiconGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<SuggestionSalpicon>>((setValue) {
  final __name = 'SuggestionSalpicon';

  final __suggestionSalpiconGraphQLType = objectType<SuggestionSalpicon>(__name,
      isInterface: false, interfaces: []);

  setValue(__suggestionSalpiconGraphQLType);
  __suggestionSalpiconGraphQLType.fields.addAll(
    [],
  );

  return __suggestionSalpiconGraphQLType;
});

/// Auto-generated from [SuggestionSalpicon].
GraphQLObjectType<SuggestionSalpicon> get suggestionSalpiconGraphQLType =>
    _suggestionSalpiconGraphQLType.value;

final _cachoDataGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<CachoData>>((setValue) {
  final __name = 'CachoData';

  final __cachoDataGraphQLType =
      objectType<CachoData>(__name, isInterface: false, interfaces: []);

  setValue(__cachoDataGraphQLType);
  __cachoDataGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLInt
          .nonNull()
          .field('totalDices', resolve: (obj, ctx) => obj.totalDices),
      graphQLBoolean
          .nonNull()
          .field('canCazar', resolve: (obj, ctx) => obj.canCazar),
      graphQLInt.field('minAs', resolve: (obj, ctx) => obj.minAs),
      graphQLInt.field('minOther', resolve: (obj, ctx) => obj.minOther),
      graphQLBoolean
          .nonNull()
          .field('isPlaying', resolve: (obj, ctx) => obj.isPlaying),
      graphQLInt
          .nonNull()
          .field('playerNumber', resolve: (obj, ctx) => obj.playerNumber),
      graphQLString
          .nonNull()
          .list()
          .nonNull()
          .field('players', resolve: (obj, ctx) => obj.players),
      graphQLString.field('currentPlayer',
          resolve: (obj, ctx) => obj.currentPlayer),
      graphQLString.field('previousPlayer',
          resolve: (obj, ctx) => obj.previousPlayer),
      suggestionGraphQLType.field('currentSuggestion',
          resolve: (obj, ctx) => obj.currentSuggestion),
      suggestionDicesGraphQLType.field('currentDiceSuggestion',
          resolve: (obj, ctx) => obj.currentDiceSuggestion),
      graphQLInt
          .nonNull()
          .list()
          .nonNull()
          .field('dices', resolve: (obj, ctx) => obj.dices),
      graphQLString.nonNull().list().nonNull().field('salpiconedPlayers',
          resolve: (obj, ctx) => obj.salpiconedPlayers)
    ],
  );

  return __cachoDataGraphQLType;
});

/// Auto-generated from [CachoData].
GraphQLObjectType<CachoData> get cachoDataGraphQLType =>
    _cachoDataGraphQLType.value;

/// Auto-generated from [CachoCommandType].
final GraphQLEnumType<CachoCommandType> cachoCommandTypeGraphQLType =
    GraphQLEnumType('CachoCommandType', [
  GraphQLEnumValue('suggest', CachoCommandType.suggest),
  GraphQLEnumValue('start', CachoCommandType.start),
  GraphQLEnumValue('cazar', CachoCommandType.cazar),
  GraphQLEnumValue('dudar', CachoCommandType.dudar)
]);

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SuggestionInput _$$_SuggestionInputFromJson(Map<String, dynamic> json) =>
    _$_SuggestionInput(
      dices: json['dices'] == null
          ? null
          : SuggestionDices.fromJson(json['dices'] as Map<String, dynamic>),
      salpicon: json['salpicon'] as bool?,
    );

Map<String, dynamic> _$$_SuggestionInputToJson(_$_SuggestionInput instance) =>
    <String, dynamic>{
      'dices': instance.dices,
      'salpicon': instance.salpicon,
    };
