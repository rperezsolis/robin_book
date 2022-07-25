import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';

/// Use case for saving a favorite work.
class AddFavoriteWorkUseCase {
  final FavoriteWorkRepository _favoriteWorkRepository;

  AddFavoriteWorkUseCase({
    required FavoriteWorkRepository favoriteWorkRepository
  }) : _favoriteWorkRepository = favoriteWorkRepository;

  /// Saves a [FavoriteWork] based on the value of [work]. Returns the id of
  /// the saved row.
  Future<int?> invoke({
    required Work work
  }) async {
    return await _favoriteWorkRepository.addFavoriteWork(work: work);
  }
}