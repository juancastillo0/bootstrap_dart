// web.dart
import 'package:bootstrap_dart_example/sql_db/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/web.dart';

SharedDatabase constructDb() {
  return SharedDatabase(LazyDatabase(() async {
    final indexedDbStorage =
        await DriftWebStorage.indexedDbIfSupported('drift');
    return WebDatabase.withStorage(indexedDbStorage);
  }));
}
