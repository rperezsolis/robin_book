import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work/work_converter.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';
import 'package:robin_book/domain/models/work_search/work_search_converter.dart';

part 'work_database.g.dart';

class WorkSearches extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get compositeId => text()();
  TextColumn get workSearch => text().map(WorkSearchConverter()).nullable()();
}

class FavoriteWorks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text()();
  TextColumn get work => text().map(WorkConverter()).nullable()();
}

@DriftDatabase(tables: [WorkSearches, FavoriteWorks])
class WorkDatabase extends _$WorkDatabase {

  static final WorkDatabase _singleton = WorkDatabase._internal();

  factory WorkDatabase() => _singleton;

  WorkDatabase._internal() : super(_openConnection()); // private constructor


  ///------------------------ Work Searches ------------------------


  Future<WorkSearch?> getWorkSearch({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    String compositeId = _createWorkSearchCompositeId(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
    WorkSearche? workSearchEntity = await (select(workSearches)
      ..where((tbl) => tbl.compositeId.equals(compositeId))).getSingleOrNull();
    return workSearchEntity?.workSearch;
  }

  Future<int?> addWorkSearch({
    required String keyword,
    required int limit,
    required int offset,
    required WorkSearch workSearch,
  }) async {
    String compositeId = _createWorkSearchCompositeId(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
    WorkSearchesCompanion entry = _getWorkSearchesCompanionInstance(
        compositeId: compositeId,
        workSearch: workSearch
    );
    WorkSearch? localWorkSearch = await getWorkSearch(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
    if (localWorkSearch == null) {
      return await into(workSearches).insert(entry);
    } else {
      return null;
    }
  }

  String _createWorkSearchCompositeId({
    required String keyword,
    required int limit,
    required int offset
  }) {
    return '$keyword-$limit-$offset';
  }

  WorkSearchesCompanion _getWorkSearchesCompanionInstance({
    required String compositeId,
    required WorkSearch workSearch
  }) {
    return WorkSearchesCompanion(
        compositeId: Value(compositeId),
        workSearch: Value(workSearch)
    );
  }


  ///------------------------ Favorite Works ------------------------


  Future<List<FavoriteWork>> get allFavoriteWorks => select(favoriteWorks).get();

  Stream<List<FavoriteWork>> get watchAllFavoriteWorks => select(favoriteWorks).watch();

  Future<FavoriteWork?> getFavoriteWork({
    required String key
  }) async {
    return await (select(favoriteWorks)..where((tbl) => tbl.key.equals(key)))
        .getSingleOrNull();
  }

  ///Returns the row id of the inserted row.
  Future<int?> addFavoriteWork({
    required Work work
  }) async {
    FavoriteWorksCompanion entry = _getFavoriteWorkCompanionInstance(work: work);
    FavoriteWork? favoriteWork = await getFavoriteWork(key: entry.key.value);
    if (favoriteWork == null) {
      return await into(favoriteWorks).insert(entry);
    } else {
      return null;
    }
  }

  ///Returns the amount of rows that were deleted by this statement directly
  Future<int?> deleteFavoriteWork({
    required String key
  }) async {
    FavoriteWork? favoriteWork = await getFavoriteWork(key: key);
    if (favoriteWork != null) {
      return await (delete(favoriteWorks)..where((tbl) => tbl.key.equals(key))).go();
    } else {
      return null;
    }
  }

  FavoriteWorksCompanion _getFavoriteWorkCompanionInstance({
    required Work work
  }) {
    return FavoriteWorksCompanion(
        key: Value(work.key),
        work: Value(work)
    );
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if(from < 2) {
            await m.create(workSearches);
          }
        }
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}