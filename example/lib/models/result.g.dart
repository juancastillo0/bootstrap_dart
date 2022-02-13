// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _resultGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<Result>>>((_) => {});

/// Auto-generated from [Result].
GraphQLObjectType<Result<T, E>>
    resultGraphQLType<T extends Object, E extends Object>(
  GraphQLType<T, Object> tGraphQLType,
  GraphQLType<E, Object> eGraphQLType, {
  String? name,
}) {
  final __name = name ??
      'Result${tGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_resultGraphQLType.value[__name] != null)
    return _resultGraphQLType.value[__name]! as GraphQLObjectType<Result<T, E>>;
  final __resultGraphQLType =
      objectType<Result<T, E>>(__name, isInterface: true, interfaces: []);

  _resultGraphQLType.value[__name] = __resultGraphQLType;
  __resultGraphQLType.fields.addAll(
    [
      tGraphQLType.nullable().field('ok', resolve: (obj, ctx) => obj.ok),
      eGraphQLType.nullable().field('err', resolve: (obj, ctx) => obj.err),
      graphQLBoolean.nonNull().field('isOk', resolve: (obj, ctx) => obj.isOk)
    ],
  );

  return __resultGraphQLType;
}
