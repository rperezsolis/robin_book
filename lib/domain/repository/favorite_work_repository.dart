import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';

class FavoriteWorkRepository {
  final WorkDatabase _workDatabase;

  FavoriteWorkRepository({
    required WorkDatabase workDatabase
  }) : _workDatabase = workDatabase;

  Future<List<FavoriteWork>> getAllFavoriteWorks() async {
    return _workDatabase.allFavoriteWorks;
  }

  Future<FavoriteWork?> getFavoriteWork({
    required String key
  }) async {
    return await _workDatabase.getFavoriteWork(key: key);
  }

  Future<int?> addFavoriteWork({
    required Work work
  }) async {
    return await _workDatabase.addFavoriteWork(work: work);
  }

  Future<int?> deleteFavoriteWork({
    required String key
  }) async {
    return await _workDatabase.deleteFavoriteWork(key: key);
  }
}