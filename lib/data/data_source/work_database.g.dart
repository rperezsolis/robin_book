// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
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
  late final $FavoriteWorksTable favoriteWorks = $FavoriteWorksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteWorks];
}
