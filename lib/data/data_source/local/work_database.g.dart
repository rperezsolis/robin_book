// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class WorkSearche extends DataClass implements Insertable<WorkSearche> {
  final int id;
  final String compositeId;
  final WorkSearch? workSearch;
  WorkSearche({required this.id, required this.compositeId, this.workSearch});
  factory WorkSearche.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WorkSearche(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      compositeId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}composite_id'])!,
      workSearch: $WorkSearchesTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}work_search'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['composite_id'] = Variable<String>(compositeId);
    if (!nullToAbsent || workSearch != null) {
      final converter = $WorkSearchesTable.$converter0;
      map['work_search'] = Variable<String?>(converter.mapToSql(workSearch));
    }
    return map;
  }

  WorkSearchesCompanion toCompanion(bool nullToAbsent) {
    return WorkSearchesCompanion(
      id: Value(id),
      compositeId: Value(compositeId),
      workSearch: workSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(workSearch),
    );
  }

  factory WorkSearche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkSearche(
      id: serializer.fromJson<int>(json['id']),
      compositeId: serializer.fromJson<String>(json['compositeId']),
      workSearch: serializer.fromJson<WorkSearch?>(json['workSearch']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'compositeId': serializer.toJson<String>(compositeId),
      'workSearch': serializer.toJson<WorkSearch?>(workSearch),
    };
  }

  WorkSearche copyWith(
          {int? id, String? compositeId, WorkSearch? workSearch}) =>
      WorkSearche(
        id: id ?? this.id,
        compositeId: compositeId ?? this.compositeId,
        workSearch: workSearch ?? this.workSearch,
      );
  @override
  String toString() {
    return (StringBuffer('WorkSearche(')
          ..write('id: $id, ')
          ..write('compositeId: $compositeId, ')
          ..write('workSearch: $workSearch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, compositeId, workSearch);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkSearche &&
          other.id == this.id &&
          other.compositeId == this.compositeId &&
          other.workSearch == this.workSearch);
}

class WorkSearchesCompanion extends UpdateCompanion<WorkSearche> {
  final Value<int> id;
  final Value<String> compositeId;
  final Value<WorkSearch?> workSearch;
  const WorkSearchesCompanion({
    this.id = const Value.absent(),
    this.compositeId = const Value.absent(),
    this.workSearch = const Value.absent(),
  });
  WorkSearchesCompanion.insert({
    this.id = const Value.absent(),
    required String compositeId,
    this.workSearch = const Value.absent(),
  }) : compositeId = Value(compositeId);
  static Insertable<WorkSearche> custom({
    Expression<int>? id,
    Expression<String>? compositeId,
    Expression<WorkSearch?>? workSearch,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (compositeId != null) 'composite_id': compositeId,
      if (workSearch != null) 'work_search': workSearch,
    });
  }

  WorkSearchesCompanion copyWith(
      {Value<int>? id,
      Value<String>? compositeId,
      Value<WorkSearch?>? workSearch}) {
    return WorkSearchesCompanion(
      id: id ?? this.id,
      compositeId: compositeId ?? this.compositeId,
      workSearch: workSearch ?? this.workSearch,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (compositeId.present) {
      map['composite_id'] = Variable<String>(compositeId.value);
    }
    if (workSearch.present) {
      final converter = $WorkSearchesTable.$converter0;
      map['work_search'] =
          Variable<String?>(converter.mapToSql(workSearch.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkSearchesCompanion(')
          ..write('id: $id, ')
          ..write('compositeId: $compositeId, ')
          ..write('workSearch: $workSearch')
          ..write(')'))
        .toString();
  }
}

class $WorkSearchesTable extends WorkSearches
    with TableInfo<$WorkSearchesTable, WorkSearche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkSearchesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _compositeIdMeta =
      const VerificationMeta('compositeId');
  @override
  late final GeneratedColumn<String?> compositeId = GeneratedColumn<String?>(
      'composite_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _workSearchMeta = const VerificationMeta('workSearch');
  @override
  late final GeneratedColumnWithTypeConverter<WorkSearch, String?> workSearch =
      GeneratedColumn<String?>('work_search', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<WorkSearch>($WorkSearchesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, compositeId, workSearch];
  @override
  String get aliasedName => _alias ?? 'work_searches';
  @override
  String get actualTableName => 'work_searches';
  @override
  VerificationContext validateIntegrity(Insertable<WorkSearche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('composite_id')) {
      context.handle(
          _compositeIdMeta,
          compositeId.isAcceptableOrUnknown(
              data['composite_id']!, _compositeIdMeta));
    } else if (isInserting) {
      context.missing(_compositeIdMeta);
    }
    context.handle(_workSearchMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkSearche map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WorkSearche.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WorkSearchesTable createAlias(String alias) {
    return $WorkSearchesTable(attachedDatabase, alias);
  }

  static TypeConverter<WorkSearch, String> $converter0 = WorkSearchConverter();
}

class FavoriteWork extends DataClass implements Insertable<FavoriteWork> {
  final int id;
  final String key;
  final Work? work;
  FavoriteWork({required this.id, required this.key, this.work});
  factory FavoriteWork.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteWork(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      work: $FavoriteWorksTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}work'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || work != null) {
      final converter = $FavoriteWorksTable.$converter0;
      map['work'] = Variable<String?>(converter.mapToSql(work));
    }
    return map;
  }

  FavoriteWorksCompanion toCompanion(bool nullToAbsent) {
    return FavoriteWorksCompanion(
      id: Value(id),
      key: Value(key),
      work: work == null && nullToAbsent ? const Value.absent() : Value(work),
    );
  }

  factory FavoriteWork.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteWork(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      work: serializer.fromJson<Work?>(json['work']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'work': serializer.toJson<Work?>(work),
    };
  }

  FavoriteWork copyWith({int? id, String? key, Work? work}) => FavoriteWork(
        id: id ?? this.id,
        key: key ?? this.key,
        work: work ?? this.work,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteWork(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('work: $work')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, work);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteWork &&
          other.id == this.id &&
          other.key == this.key &&
          other.work == this.work);
}

class FavoriteWorksCompanion extends UpdateCompanion<FavoriteWork> {
  final Value<int> id;
  final Value<String> key;
  final Value<Work?> work;
  const FavoriteWorksCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.work = const Value.absent(),
  });
  FavoriteWorksCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    this.work = const Value.absent(),
  }) : key = Value(key);
  static Insertable<FavoriteWork> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<Work?>? work,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (work != null) 'work': work,
    });
  }

  FavoriteWorksCompanion copyWith(
      {Value<int>? id, Value<String>? key, Value<Work?>? work}) {
    return FavoriteWorksCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      work: work ?? this.work,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (work.present) {
      final converter = $FavoriteWorksTable.$converter0;
      map['work'] = Variable<String?>(converter.mapToSql(work.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteWorksCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('work: $work')
          ..write(')'))
        .toString();
  }
}

class $FavoriteWorksTable extends FavoriteWorks
    with TableInfo<$FavoriteWorksTable, FavoriteWork> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteWorksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String?> key = GeneratedColumn<String?>(
      'key', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _workMeta = const VerificationMeta('work');
  @override
  late final GeneratedColumnWithTypeConverter<Work, String?> work =
      GeneratedColumn<String?>('work', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Work>($FavoriteWorksTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, key, work];
  @override
  String get aliasedName => _alias ?? 'favorite_works';
  @override
  String get actualTableName => 'favorite_works';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteWork> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    context.handle(_workMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteWork map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoriteWork.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteWorksTable createAlias(String alias) {
    return $FavoriteWorksTable(attachedDatabase, alias);
  }

  static TypeConverter<Work, String> $converter0 = WorkConverter();
}

abstract class _$WorkDatabase extends GeneratedDatabase {
  _$WorkDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $WorkSearchesTable workSearches = $WorkSearchesTable(this);
  late final $FavoriteWorksTable favoriteWorks = $FavoriteWorksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [workSearches, favoriteWorks];
}
