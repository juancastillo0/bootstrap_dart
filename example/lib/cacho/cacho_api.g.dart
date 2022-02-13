// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cacho_api.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<CachoData, Object?, Object?> get createCachoGraphQLField =>
    _createCachoGraphQLField.value;
final _createCachoGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<CachoData, Object?, Object?>>(
        (setValue) => setValue(cachoDataGraphQLType.nonNull().field<Object?>(
              'createCacho',
              resolve: (obj, ctx) {
                final args = ctx.args;

                final _call = (CachoGQLApi r) => r.createCacho(ctx);
                // ignore: unnecessary_non_null_assertion
                final FutureOr<CachoGQLApi> _obj = CachoGQLApi.ref.get(ctx)!;
                if (_obj is Future<CachoGQLApi>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
            )));

GraphQLObjectField<Result<CachoData, String>, Object?, Object?>
    get sendCachoCommandGraphQLField => _sendCachoCommandGraphQLField.value;
final _sendCachoCommandGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<Result<CachoData, String>, Object?, Object?>>(
    (setValue) => setValue(resultGraphQLType<CachoData, String>(
                cachoDataGraphQLType.nonNull(), graphQLString.nonNull())
            .nonNull()
            .field<Object?>(
          'sendCachoCommand',
          resolve: (obj, ctx) {
            final args = ctx.args;

            final _call = (CachoGQLApi r) => r.sendCachoCommand(
                ctx,
                (args["gameId"] as String),
                (args["command"] as CachoCommandInput));
            // ignore: unnecessary_non_null_assertion
            final FutureOr<CachoGQLApi> _obj = CachoGQLApi.ref.get(ctx)!;
            if (_obj is Future<CachoGQLApi>)
              return _obj.then(_call);
            else
              return _call(_obj);
          },
        ))
          ..inputs.addAll([
            graphQLString.nonNull().inputField('gameId'),
            cachoCommandInputGraphQLTypeInput.nonNull().inputField('command')
          ]));

GraphQLObjectField<CachoData, Object?, Object?> get cachoStateGraphQLField =>
    _cachoStateGraphQLField.value;
final _cachoStateGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<CachoData, Object?, Object?>>(
        (setValue) => setValue(cachoDataGraphQLType.nonNull().field<Object?>(
              'cachoState',
              subscribe: (obj, ctx) {
                final args = ctx.args;

                final _call = (CachoGQLApi r) =>
                    r.cachoState(ctx, (args["gameId"] as String));
                // ignore: unnecessary_non_null_assertion
                final FutureOr<CachoGQLApi> _obj = CachoGQLApi.ref.get(ctx)!;
                if (_obj is Future<CachoGQLApi>)
                  return _obj.then(_call);
                else
                  return _call(_obj);
              },
            ))
              ..inputs.addAll([graphQLString.nonNull().inputField('gameId')]));
