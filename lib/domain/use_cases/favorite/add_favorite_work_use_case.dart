import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';

class AddFavoriteWorkUseCase {
  final FavoriteWorkRepository _favoriteWorkRepository;

  AddFavoriteWorkUseCase({
    required FavoriteWorkRepository favoriteWorkRepository
  }) : _favoriteWorkRepository = favoriteWorkRepository;

  Future<int?> invoke({
    required Work work
  }) async {
    return await _favoriteWorkRepository.addFavoriteWork(work: work);
  }
}