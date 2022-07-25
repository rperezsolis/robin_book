import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';

/// Class for handle [FavoriteWork] related data operations.
class FavoriteWorkRepository {
  final WorkDatabase _workDatabase;

  FavoriteWorkRepository({
    required WorkDatabase workDatabase
  }) : _workDatabase = workDatabase;

  /// Returns a list of all the saved favorite works.
  Future<List<FavoriteWork>> getAllFavoriteWorks() async {
    return _workDatabase.allFavoriteWorks;
  }

  /// Returns a [FavoriteWork] related to the [key] if any.
  Future<FavoriteWork?> getFavoriteWork({
    required String key
  }) async {
    return await _workDatabase.getFavoriteWork(key: key);
  }

  /// Saves a [FavoriteWork] based on the value of [work]. Returns the row id of
  /// the inserted row.
  Future<int?> addFavoriteWork({
    required Work work
  }) async {
    return await _workDatabase.addFavoriteWork(work: work);
  }

  /// Deletes a [FavoriteWork] related to the [key] if any. Returns the amount
  /// of rows that were deleted.
  Future<int?> deleteFavoriteWork({
    required String key
  }) async {
    return await _workDatabase.deleteFavoriteWork(key: key);
  }
}