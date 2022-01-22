import 'package:bootstrap_dart_example/sql_db/event_source.dart';
import 'package:drift/drift.dart';
// don't import drift/web.dart or drift/native.dart in shared code
export '_native_drift.dart' if (dart.library.html) '_web_drift.dart';

part 'database.g.dart';

// unsupported.dart
// SharedDatabase constructDb() => throw UnimplementedError();

@DriftDatabase(
  include: {'tables.drift'},
)
class SharedDatabase extends _$SharedDatabase implements EventSourceRepo {
  SharedDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy();

  @override
  Future<List<CommandData>> getCommands({
    required String stateId,
    required int? lastCommandId,
  }) {
    return selectCommands(stateId: stateId, lastCommandId: lastCommandId).get();
  }
}
