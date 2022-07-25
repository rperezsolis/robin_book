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

/// Class for saving in cache the book searches the user does.
class WorkSearches extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get compositeId => text()();
  TextColumn get workSearch => text().map(WorkSearchConverter()).nullable()();
}

/// Class for saving in cache the books the user saves as favorites.
class FavoriteWorks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text()();
  TextColumn get work => text().map(WorkConverter()).nullable()();
}

/// This class is the local datasource for books.
@DriftDatabase(tables: [WorkSearches, FavoriteWorks])
class WorkDatabase extends _$WorkDatabase {

  static final WorkDatabase _singleton = WorkDatabase._internal();

  factory WorkDatabase() => _singleton;

  WorkDatabase._internal() : super(_openConnection()); // private constructor


  ///------------------------ Work Searches ------------------------


  /// Returns a [WorkSearch] identified by a combination of the [keyword],
  /// [limit], and [offset].
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

  /// Saves a [WorkSearch] identified by a combination of the [keyword],
  /// [limit], and [offset]. Returns the row id [int] of the inserted row.
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

  /// Returns a composite id meant to be the identifier of a [WorkSearch].
  /// The resultant id is a concatenation of the values for [keyword], [limit],
  /// and [offset].
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


  /// Returns a list of all the saved favorite works.
  Future<List<FavoriteWork>> get allFavoriteWorks => select(favoriteWorks).get();

  /// Returns a stream that contains a list of all the saved favorite works.
  Stream<List<FavoriteWork>> get watchAllFavoriteWorks => select(favoriteWorks).watch();

  /// Returns a [FavoriteWork] related to the [key] if any.
  Future<FavoriteWork?> getFavoriteWork({
    required String key
  }) async {
    return await (select(favoriteWorks)..where((tbl) => tbl.key.equals(key)))
        .getSingleOrNull();
  }

  /// Saves a [FavoriteWork] based on the value of [work]. Returns the row id of
  /// the inserted row.
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

  /// Deletes a [FavoriteWork] related to the [key] if any. Returns the amount
  /// of rows that were deleted.
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

  /// Version of the database schema.
  @override
  int get schemaVersion => 2;

  /// Migration instructions. These are executed automatically when Drift detects
  /// there is a change on the [schemaVersion].
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

/// Returns the database instance.
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