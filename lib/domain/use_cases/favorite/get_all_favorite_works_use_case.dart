import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';

class GetAllFavoriteWorksUseCase {
  final FavoriteWorkRepository _favoriteWorkRepository;

  GetAllFavoriteWorksUseCase({
    required FavoriteWorkRepository favoriteWorkRepository
  }) : _favoriteWorkRepository = favoriteWorkRepository;

  Future<List<FavoriteWork>> invoke() async {
    return await _favoriteWorkRepository.getAllFavoriteWorks();
  }
}