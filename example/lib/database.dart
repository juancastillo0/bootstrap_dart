import 'dart:async';
import 'package:bootstrap_dart/server_renderer.dart';
import 'package:bootstrap_dart_example/continental/continental_view.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:idb_shim/idb.dart' as idb;

Object? _castValue(Object? value) => value is Map
    ? castMap(value)
    : value is List
        ? castList(value)
        : value;

Map<String, Object?> castMap(Map map) {
  return map.map((key, value) => MapEntry(key, _castValue(value)));
}

List<Object?> castList(List map) {
  return map.map(_castValue).toList();
}

class ClientDB {
  static const dbName = 'continental_commands';
  static const commandsTableName = 'commands';
  static const storesTableName = 'stores';

  static Completer<idb.Database?>? _completer;
  static Future<idb.Database?> get() async {
    if (!kIsWeb) return null;
    if (_completer != null) return _completer!.future;
    _completer = Completer();

    final db = await getIdbFactory()!.open(
      dbName,
      version: 2,
      onUpgradeNeeded: (change) {
        final db = change.database;
        if (change.newVersion == 1) {
          final objectStore = db.createObjectStore(
            commandsTableName,
            autoIncrement: true,
          );
          objectStore.createIndex(
            'continentalStore',
            'storeKey',
            unique: false,
          );
        } else if (change.newVersion == 2) {
          db.createObjectStore(storesTableName, keyPath: 'key');
        }
      },
    );
    _completer!.complete(db);
    return _completer!.future;
  }

  static Future<void> saveStore(ContinentalClientStore store) async {
    final json = store.toJson()
      ..['key'] = '${store.data.key}-${store.data.playerId}';
    final db = await get();
    if (db == null) return;

    final tx = db.transaction(storesTableName, 'readwrite');
    final objStore = tx.objectStore(storesTableName);
    await objStore.put(json);
    await tx.completed;
  }

  static Future<Map<String, Object?>?> getStore({
    required String storeKey,
    required String playerId,
  }) async {
    final db = await get();
    if (db == null) return null;

    final tx = db.transaction(storesTableName, 'readonly');
    final value =
        await tx.objectStore(storesTableName).getObject('$storeKey-$playerId');
    await tx.completed;
    return value is Map ? castMap(value) : null;
  }
}
