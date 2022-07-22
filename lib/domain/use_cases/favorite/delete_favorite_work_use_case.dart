import 'package:robin_book/domain/repository/favorite_work_repository.dart';

class DeleteFavoriteWorkUseCase {
  final FavoriteWorkRepository _favoriteWorkRepository;

  DeleteFavoriteWorkUseCase({
    required FavoriteWorkRepository favoriteWorkRepository
  }) : _favoriteWorkRepository = favoriteWorkRepository;

  Future<int?> invoke({
    required String key
  }) async {
    return await _favoriteWorkRepository.deleteFavoriteWork(key: key);
  }
}