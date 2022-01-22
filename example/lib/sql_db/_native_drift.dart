// native.dart
import 'dart:io';

import 'package:bootstrap_dart_example/sql_db/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

SharedDatabase constructDb() {
  final db = LazyDatabase(() async {
    // final dbFolder = await getApplicationDocumentsDirectory();
    // final file = File(p.join(dbFolder.path, 'db.sqlite'));
    final filePath = [...Platform.script.pathSegments, 'db.sqlite']
        .join(Platform.pathSeparator);
    final file = File(filePath);
    return NativeDatabase(file);
  });
  return SharedDatabase(db);
}
