import 'dart:async';

import 'package:bootstrap_dart_example/cacho/cacho_command.dart';
import 'package:bootstrap_dart_example/cacho/cacho_store.dart';
import 'package:bootstrap_dart_example/models/result.dart';
import 'package:bootstrap_dart_example/sql_db/database.dart';
import 'package:bootstrap_dart_example/utils.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:mobx/mobx.dart';

part 'cacho_api.g.dart';

class CachoApi {
  final stores = Map<String, CachoStore>();

  CachoApi();

  static final ref = RefWithDefault.global((_) => CachoApi());
}

final databaseRef = RefWithDefault.global((_) => constructDb());

@ClassResolver()
class CachoGQLApi {
  const CachoGQLApi({required this.api});

  final CachoApi api;

  static final ref = RefWithDefault.global(
    (holder) => CachoGQLApi(api: CachoApi.ref.get(holder)),
  );

  @Mutation()
  CachoData createCacho(Ctx ctx) {
    final userId = userIdFromCtx(ctx);
    final id = customId();
    final store = CachoStore(key: id, db: databaseRef.get(ctx));
    api.stores[id] = store;
    final data = store.data(userId);

    return data;
  }

  @Mutation()
  Future<Result<CachoData, String>> sendCachoCommand(
    Ctx ctx,
    String gameId,
    CachoCommandInput command,
  ) async {
    final userId = userIdFromCtx(ctx);
    final store = api.stores[gameId];
    if (store == null) return Err('Store "$gameId" not found.');

    final result = await store.consume(command.asCommand());
    if (result != null) {
      return Err(result.error);
    }
    return Ok(store.data(userId));
    // if (kIsWeb) {
    //   final response = await http.post(
    //     Uri.parse('/graphql'),
    //     body: jsonEncode({
    //       'query': r'mutation m($gameId: String!, $command: CachoCommand!){'
    //           r'sendCachoCommand(gameId: $gameId, command: $command)}',
    //       'variables': {'gameId': gameId, 'command': command},
    //     }),
    //     headers: {
    //       'accept': 'application/json',
    //       'content-type': 'application/json'
    //     },
    //   );
    // }
  }

  @Subscription()
  Stream<CachoData> cachoState(Ctx ctx, String gameId) {
    final store = api.stores[gameId];
    if (store == null) throw 'Store "$gameId" not found.';
    final userId = userIdFromCtx(ctx);

    final controller = StreamController<CachoData>();
    final disposer = autorun((r) {
      controller.add(store.data(userId));
    });
    controller.onCancel = disposer.call;
    return controller.stream;
  }
}

String userIdFromCtx(Ctx ctx) {
  return ctx.request.headers['Authorization']!;
}

// TODO: voting