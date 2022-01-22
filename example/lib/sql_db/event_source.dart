import 'package:bootstrap_dart_example/sql_db/database.dart';

abstract class EventSourceRepo {
  Future<List<CommandData>> getCommands({
    required String stateId,
    required int? lastCommandId,
  });

  Future<int> insertCommand({
    required String payload,
    required String type,
    required String userId,
    required String stateId,
  });

  Future<int> insertState({
    required String id,
    required String type,
    required String payload,
  });

  Future<int> updateState({
    required String payload,
    required int? lastCommandId,
    required String id,
  });
}
