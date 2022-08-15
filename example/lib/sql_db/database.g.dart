// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ContinentalCommand extends DataClass
    implements Insertable<ContinentalCommand> {
  final int id;
  final String storeId;
  final String payload;
  final String playerId;
  ContinentalCommand(
      {required this.id,
      required this.storeId,
      required this.payload,
      required this.playerId});
  factory ContinentalCommand.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContinentalCommand(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      storeId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storeId'])!,
      payload: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payload'])!,
      playerId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playerId'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['storeId'] = Variable<String>(storeId);
    map['payload'] = Variable<String>(payload);
    map['playerId'] = Variable<String>(playerId);
    return map;
  }

  ContinentalCommandsCompanion toCompanion(bool nullToAbsent) {
    return ContinentalCommandsCompanion(
      id: Value(id),
      storeId: Value(storeId),
      payload: Value(payload),
      playerId: Value(playerId),
    );
  }

  factory ContinentalCommand.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContinentalCommand(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<String>(json['storeId']),
      payload: serializer.fromJson<String>(json['payload']),
      playerId: serializer.fromJson<String>(json['playerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<String>(storeId),
      'payload': serializer.toJson<String>(payload),
      'playerId': serializer.toJson<String>(playerId),
    };
  }

  ContinentalCommand copyWith(
          {int? id, String? storeId, String? payload, String? playerId}) =>
      ContinentalCommand(
        id: id ?? this.id,
        storeId: storeId ?? this.storeId,
        payload: payload ?? this.payload,
        playerId: playerId ?? this.playerId,
      );
  @override
  String toString() {
    return (StringBuffer('ContinentalCommand(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('payload: $payload, ')
          ..write('playerId: $playerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storeId, payload, playerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContinentalCommand &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.payload == this.payload &&
          other.playerId == this.playerId);
}

class ContinentalCommandsCompanion extends UpdateCompanion<ContinentalCommand> {
  final Value<int> id;
  final Value<String> storeId;
  final Value<String> payload;
  final Value<String> playerId;
  const ContinentalCommandsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.payload = const Value.absent(),
    this.playerId = const Value.absent(),
  });
  ContinentalCommandsCompanion.insert({
    this.id = const Value.absent(),
    required String storeId,
    required String payload,
    required String playerId,
  })  : storeId = Value(storeId),
        payload = Value(payload),
        playerId = Value(playerId);
  static Insertable<ContinentalCommand> custom({
    Expression<int>? id,
    Expression<String>? storeId,
    Expression<String>? payload,
    Expression<String>? playerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'storeId': storeId,
      if (payload != null) 'payload': payload,
      if (playerId != null) 'playerId': playerId,
    });
  }

  ContinentalCommandsCompanion copyWith(
      {Value<int>? id,
      Value<String>? storeId,
      Value<String>? payload,
      Value<String>? playerId}) {
    return ContinentalCommandsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      payload: payload ?? this.payload,
      playerId: playerId ?? this.playerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['storeId'] = Variable<String>(storeId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (playerId.present) {
      map['playerId'] = Variable<String>(playerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContinentalCommandsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('payload: $payload, ')
          ..write('playerId: $playerId')
          ..write(')'))
        .toString();
  }
}

class ContinentalCommands extends Table
    with TableInfo<ContinentalCommands, ContinentalCommand> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ContinentalCommands(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  late final GeneratedColumn<String?> storeId = GeneratedColumn<String?>(
      'storeId', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES continental_state(id)');
  final VerificationMeta _payloadMeta = const VerificationMeta('payload');
  late final GeneratedColumn<String?> payload = GeneratedColumn<String?>(
      'payload', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _playerIdMeta = const VerificationMeta('playerId');
  late final GeneratedColumn<String?> playerId = GeneratedColumn<String?>(
      'playerId', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, storeId, payload, playerId];
  @override
  String get aliasedName => _alias ?? 'continental_commands';
  @override
  String get actualTableName => 'continental_commands';
  @override
  VerificationContext validateIntegrity(Insertable<ContinentalCommand> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('storeId')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['storeId']!, _storeIdMeta));
    } else if (isInserting) {
      context.missing(_storeIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('playerId')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['playerId']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContinentalCommand map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ContinentalCommand.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  ContinentalCommands createAlias(String alias) {
    return ContinentalCommands(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ContinentalStateData extends DataClass
    implements Insertable<ContinentalStateData> {
  final String id;
  final String payload;
  ContinentalStateData({required this.id, required this.payload});
  factory ContinentalStateData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContinentalStateData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      payload: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payload'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payload'] = Variable<String>(payload);
    return map;
  }

  ContinentalStateCompanion toCompanion(bool nullToAbsent) {
    return ContinentalStateCompanion(
      id: Value(id),
      payload: Value(payload),
    );
  }

  factory ContinentalStateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContinentalStateData(
      id: serializer.fromJson<String>(json['id']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'payload': serializer.toJson<String>(payload),
    };
  }

  ContinentalStateData copyWith({String? id, String? payload}) =>
      ContinentalStateData(
        id: id ?? this.id,
        payload: payload ?? this.payload,
      );
  @override
  String toString() {
    return (StringBuffer('ContinentalStateData(')
          ..write('id: $id, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContinentalStateData &&
          other.id == this.id &&
          other.payload == this.payload);
}

class ContinentalStateCompanion extends UpdateCompanion<ContinentalStateData> {
  final Value<String> id;
  final Value<String> payload;
  const ContinentalStateCompanion({
    this.id = const Value.absent(),
    this.payload = const Value.absent(),
  });
  ContinentalStateCompanion.insert({
    required String id,
    required String payload,
  })  : id = Value(id),
        payload = Value(payload);
  static Insertable<ContinentalStateData> custom({
    Expression<String>? id,
    Expression<String>? payload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payload != null) 'payload': payload,
    });
  }

  ContinentalStateCompanion copyWith(
      {Value<String>? id, Value<String>? payload}) {
    return ContinentalStateCompanion(
      id: id ?? this.id,
      payload: payload ?? this.payload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContinentalStateCompanion(')
          ..write('id: $id, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }
}

class ContinentalState extends Table
    with TableInfo<ContinentalState, ContinentalStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ContinentalState(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  final VerificationMeta _payloadMeta = const VerificationMeta('payload');
  late final GeneratedColumn<String?> payload = GeneratedColumn<String?>(
      'payload', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, payload];
  @override
  String get aliasedName => _alias ?? 'continental_state';
  @override
  String get actualTableName => 'continental_state';
  @override
  VerificationContext validateIntegrity(
      Insertable<ContinentalStateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContinentalStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ContinentalStateData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  ContinentalState createAlias(String alias) {
    return ContinentalState(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CommandData extends DataClass implements Insertable<CommandData> {
  final int id;
  final String type;
  final String stateId;
  final String userId;
  final String payload;
  CommandData(
      {required this.id,
      required this.type,
      required this.stateId,
      required this.userId,
      required this.payload});
  factory CommandData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CommandData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      stateId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}stateId'])!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}userId'])!,
      payload: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payload'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['stateId'] = Variable<String>(stateId);
    map['userId'] = Variable<String>(userId);
    map['payload'] = Variable<String>(payload);
    return map;
  }

  CommandCompanion toCompanion(bool nullToAbsent) {
    return CommandCompanion(
      id: Value(id),
      type: Value(type),
      stateId: Value(stateId),
      userId: Value(userId),
      payload: Value(payload),
    );
  }

  factory CommandData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommandData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      stateId: serializer.fromJson<String>(json['stateId']),
      userId: serializer.fromJson<String>(json['userId']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'stateId': serializer.toJson<String>(stateId),
      'userId': serializer.toJson<String>(userId),
      'payload': serializer.toJson<String>(payload),
    };
  }

  CommandData copyWith(
          {int? id,
          String? type,
          String? stateId,
          String? userId,
          String? payload}) =>
      CommandData(
        id: id ?? this.id,
        type: type ?? this.type,
        stateId: stateId ?? this.stateId,
        userId: userId ?? this.userId,
        payload: payload ?? this.payload,
      );
  @override
  String toString() {
    return (StringBuffer('CommandData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('stateId: $stateId, ')
          ..write('userId: $userId, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, stateId, userId, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommandData &&
          other.id == this.id &&
          other.type == this.type &&
          other.stateId == this.stateId &&
          other.userId == this.userId &&
          other.payload == this.payload);
}

class CommandCompanion extends UpdateCompanion<CommandData> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> stateId;
  final Value<String> userId;
  final Value<String> payload;
  const CommandCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.stateId = const Value.absent(),
    this.userId = const Value.absent(),
    this.payload = const Value.absent(),
  });
  CommandCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String stateId,
    required String userId,
    required String payload,
  })  : type = Value(type),
        stateId = Value(stateId),
        userId = Value(userId),
        payload = Value(payload);
  static Insertable<CommandData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? stateId,
    Expression<String>? userId,
    Expression<String>? payload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (stateId != null) 'stateId': stateId,
      if (userId != null) 'userId': userId,
      if (payload != null) 'payload': payload,
    });
  }

  CommandCompanion copyWith(
      {Value<int>? id,
      Value<String>? type,
      Value<String>? stateId,
      Value<String>? userId,
      Value<String>? payload}) {
    return CommandCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      stateId: stateId ?? this.stateId,
      userId: userId ?? this.userId,
      payload: payload ?? this.payload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (stateId.present) {
      map['stateId'] = Variable<String>(stateId.value);
    }
    if (userId.present) {
      map['userId'] = Variable<String>(userId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommandCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('stateId: $stateId, ')
          ..write('userId: $userId, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }
}

class Command extends Table with TableInfo<Command, CommandData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Command(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _stateIdMeta = const VerificationMeta('stateId');
  late final GeneratedColumn<String?> stateId = GeneratedColumn<String?>(
      'stateId', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES state(id)');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'userId', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _payloadMeta = const VerificationMeta('payload');
  late final GeneratedColumn<String?> payload = GeneratedColumn<String?>(
      'payload', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, type, stateId, userId, payload];
  @override
  String get aliasedName => _alias ?? 'command';
  @override
  String get actualTableName => 'command';
  @override
  VerificationContext validateIntegrity(Insertable<CommandData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('stateId')) {
      context.handle(_stateIdMeta,
          stateId.isAcceptableOrUnknown(data['stateId']!, _stateIdMeta));
    } else if (isInserting) {
      context.missing(_stateIdMeta);
    }
    if (data.containsKey('userId')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['userId']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommandData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CommandData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Command createAlias(String alias) {
    return Command(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class StateData extends DataClass implements Insertable<StateData> {
  final String id;
  final String type;
  final int? lastCommandId;
  final String payload;
  StateData(
      {required this.id,
      required this.type,
      this.lastCommandId,
      required this.payload});
  factory StateData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return StateData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      lastCommandId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lastCommandId']),
      payload: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payload'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || lastCommandId != null) {
      map['lastCommandId'] = Variable<int?>(lastCommandId);
    }
    map['payload'] = Variable<String>(payload);
    return map;
  }

  StateCompanion toCompanion(bool nullToAbsent) {
    return StateCompanion(
      id: Value(id),
      type: Value(type),
      lastCommandId: lastCommandId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCommandId),
      payload: Value(payload),
    );
  }

  factory StateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StateData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      lastCommandId: serializer.fromJson<int?>(json['lastCommandId']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'lastCommandId': serializer.toJson<int?>(lastCommandId),
      'payload': serializer.toJson<String>(payload),
    };
  }

  StateData copyWith(
          {String? id,
          String? type,
          Value<int?> lastCommandId = const Value.absent(),
          String? payload}) =>
      StateData(
        id: id ?? this.id,
        type: type ?? this.type,
        lastCommandId:
            lastCommandId.present ? lastCommandId.value : this.lastCommandId,
        payload: payload ?? this.payload,
      );
  @override
  String toString() {
    return (StringBuffer('StateData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('lastCommandId: $lastCommandId, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, lastCommandId, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StateData &&
          other.id == this.id &&
          other.type == this.type &&
          other.lastCommandId == this.lastCommandId &&
          other.payload == this.payload);
}

class StateCompanion extends UpdateCompanion<StateData> {
  final Value<String> id;
  final Value<String> type;
  final Value<int?> lastCommandId;
  final Value<String> payload;
  const StateCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.lastCommandId = const Value.absent(),
    this.payload = const Value.absent(),
  });
  StateCompanion.insert({
    required String id,
    required String type,
    this.lastCommandId = const Value.absent(),
    required String payload,
  })  : id = Value(id),
        type = Value(type),
        payload = Value(payload);
  static Insertable<StateData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int?>? lastCommandId,
    Expression<String>? payload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (lastCommandId != null) 'lastCommandId': lastCommandId,
      if (payload != null) 'payload': payload,
    });
  }

  StateCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<int?>? lastCommandId,
      Value<String>? payload}) {
    return StateCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      lastCommandId: lastCommandId ?? this.lastCommandId,
      payload: payload ?? this.payload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (lastCommandId.present) {
      map['lastCommandId'] = Variable<int?>(lastCommandId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StateCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('lastCommandId: $lastCommandId, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }
}

class State extends Table with TableInfo<State, StateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  State(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _lastCommandIdMeta =
      const VerificationMeta('lastCommandId');
  late final GeneratedColumn<int?> lastCommandId = GeneratedColumn<int?>(
      'lastCommandId', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES command(id)');
  final VerificationMeta _payloadMeta = const VerificationMeta('payload');
  late final GeneratedColumn<String?> payload = GeneratedColumn<String?>(
      'payload', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, type, lastCommandId, payload];
  @override
  String get aliasedName => _alias ?? 'state';
  @override
  String get actualTableName => 'state';
  @override
  VerificationContext validateIntegrity(Insertable<StateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('lastCommandId')) {
      context.handle(
          _lastCommandIdMeta,
          lastCommandId.isAcceptableOrUnknown(
              data['lastCommandId']!, _lastCommandIdMeta));
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return StateData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  State createAlias(String alias) {
    return State(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$SharedDatabase extends GeneratedDatabase {
  _$SharedDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final ContinentalCommands continentalCommands =
      ContinentalCommands(this);
  late final ContinentalState continentalState = ContinentalState(this);
  late final Command command = Command(this);
  late final State state = State(this);
  Selectable<ContinentalCommand> selectContinentalCommands(
      {required String storeId}) {
    return customSelect(
        'SELECT * FROM continental_commands WHERE storeId = :storeId ORDER BY id',
        variables: [
          Variable<String>(storeId)
        ],
        readsFrom: {
          continentalCommands,
        }).map(continentalCommands.mapFromRow);
  }

  Future<int> insertContinentalCommand(
      {required String payload,
      required String playerId,
      required String storeId}) {
    return customInsert(
      'INSERT INTO continental_commands (payload, playerId, storeId) VALUES (:payload, :playerId, :storeId)',
      variables: [
        Variable<String>(payload),
        Variable<String>(playerId),
        Variable<String>(storeId)
      ],
      updates: {continentalCommands},
    );
  }

  Future<int> insertContinentalState(
      {required String id, required String payload}) {
    return customInsert(
      'INSERT INTO continental_state (id, payload) VALUES (:id, :payload)',
      variables: [Variable<String>(id), Variable<String>(payload)],
      updates: {continentalState},
    );
  }

  Future<int> updateContinentalState(
      {required String payload, required String id}) {
    return customUpdate(
      'UPDATE continental_state SET payload = :payload where id = :id',
      variables: [Variable<String>(payload), Variable<String>(id)],
      updates: {continentalState},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<CommandData> selectCommands(
      {required String stateId, int? lastCommandId}) {
    return customSelect(
        'SELECT * FROM command\n    WHERE stateId = :stateId AND id > :lastCommandId ORDER BY id',
        variables: [
          Variable<String>(stateId),
          Variable<int?>(lastCommandId)
        ],
        readsFrom: {
          command,
        }).map(command.mapFromRow);
  }

  Future<int> insertCommand(
      {required String payload,
      required String type,
      required String userId,
      required String stateId}) {
    return customInsert(
      'INSERT INTO command (payload, type, userId, stateId) VALUES (:payload, :type, :userId, :stateId)',
      variables: [
        Variable<String>(payload),
        Variable<String>(type),
        Variable<String>(userId),
        Variable<String>(stateId)
      ],
      updates: {command},
    );
  }

  Future<int> insertState(
      {required String id, required String type, required String payload}) {
    return customInsert(
      'INSERT INTO state (id, type, payload) VALUES (:id, :type, :payload)',
      variables: [
        Variable<String>(id),
        Variable<String>(type),
        Variable<String>(payload)
      ],
      updates: {state},
    );
  }

  Future<int> updateState(
      {required String payload,
      required int? lastCommandId,
      required String id}) {
    return customUpdate(
      'UPDATE state SET payload = :payload, lastCommandId = :lastCommandId where id = :id',
      variables: [
        Variable<String>(payload),
        Variable<int?>(lastCommandId),
        Variable<String>(id)
      ],
      updates: {state},
      updateKind: UpdateKind.update,
    );
  }

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [continentalCommands, continentalState, command, state];
}
