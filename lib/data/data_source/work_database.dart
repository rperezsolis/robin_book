import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:robin_book/domain/work/work.dart';
import 'package:robin_book/domain/work/work_converter.dart';

part 'work_database.g.dart';

class FavoriteWorks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text()();
  TextColumn get work => text().map(WorkConverter()).nullable()();
}

@DriftDatabase(tables: [FavoriteWorks])
class WorkDatabase extends _$WorkDatabase {

  WorkDatabase() : super(_openConnection());

  Future<List<FavoriteWork>> get allFavoriteWorks => select(favoriteWorks).get();

  Stream<List<FavoriteWork>> get watchAllFavoriteWorks => select(favoriteWorks).watch();

  Future<FavoriteWork?> getFavoriteBook({
    required String key
  }) async {
    return await (select(favoriteWorks)..where((tbl) => tbl.key.equals(key)))
        .getSingleOrNull();
  }

  ///Returns the row id of the inserted row.
  Future<int?> addFavoriteBook({
    required Work work
  }) async {
    FavoriteWorksCompanion entry = _getFavoriteWorkCompanionInstance(work: work);
    FavoriteWork? favoriteWork = await getFavoriteBook(key: entry.key.value);
    if (favoriteWork == null) {
      return await into(favoriteWorks).insert(entry);
    } else {
      return null;
    }
  }

  ///Returns the amount of rows that were deleted by this statement directly
  Future<int?> deleteFavoriteBook({
    required String key
  }) async {
    FavoriteWork? favoriteWork = await getFavoriteBook(key: key);
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
  int get schemaVersion => 1;
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