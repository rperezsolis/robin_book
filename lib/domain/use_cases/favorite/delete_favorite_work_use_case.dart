import 'package:robin_book/domain/repository/favorite_work_repository.dart';

/// Use case for deleting a work.
class DeleteFavoriteWorkUseCase {
  final FavoriteWorkRepository _favoriteWorkRepository;

  DeleteFavoriteWorkUseCase({
    required FavoriteWorkRepository favoriteWorkRepository
  }) : _favoriteWorkRepository = favoriteWorkRepository;

  /// Deletes a [FavoriteWork] related to the [key] if any. Returns the amount
  /// of favorite works that were deleted.
  Future<int?> invoke({
    required String key
  }) async {
    return await _favoriteWorkRepository.deleteFavoriteWork(key: key);
  }
}