import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';

/// Use case for retrieving a favorite work.
class GetFavoriteWorkUseCase {

  final FavoriteWorkRepository _favoriteWorkRepository;

  GetFavoriteWorkUseCase({
    required FavoriteWorkRepository favoriteWorkRepository
  }) : _favoriteWorkRepository = favoriteWorkRepository;

  /// Returns a [FavoriteWork] related to the [key] if any.
  Future<FavoriteWork?> invoke({
    required String key
  }) async {
    return await _favoriteWorkRepository.getFavoriteWork(key: key);
  }
}