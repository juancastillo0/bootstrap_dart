// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:bootstrap_dart_example/cacho/cacho_api.dart';
import 'package:bootstrap_dart_example/models/result.dart';
import 'package:bootstrap_dart_example/cacho/cacho_command.dart';

GraphQLSchema recreateGraphQLApiSchema() {
  HotReloadableDefinition.incrementCounter();
  _graphqlApiSchema = null;
  return graphqlApiSchema;
}

GraphQLSchema? _graphqlApiSchema;
GraphQLSchema get graphqlApiSchema => _graphqlApiSchema ??= GraphQLSchema(
      serdeCtx: SerdeCtx()
        ..addAll([
          cachoCommandInputSerializer,
          cachoCommandSerializer,
          cachoCommandSuggestSerializer,
          suggestionInputSerializer,
          suggestionSerializer,
          suggestionDicesSerializer,
        ])
        ..children.addAll([]),
      queryType: objectType(
        'Query',
        fields: [
          cachoGamesGraphQLField,
        ],
      ),
      mutationType: objectType(
        'Mutation',
        fields: [
          createCachoGraphQLField,
          sendCachoCommandGraphQLField,
        ],
      ),
      subscriptionType: objectType(
        'Subscription',
        fields: [
          cachoStateGraphQLField,
        ],
      ),
    );
