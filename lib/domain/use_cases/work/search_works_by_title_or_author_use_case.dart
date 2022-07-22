import 'package:robin_book/domain/models/work_search/work_search.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

class SearchWorksByTitleOrAuthorUseCase {
  final WorkRepository _workRepository;

  SearchWorksByTitleOrAuthorUseCase({required workRepository})
      : _workRepository = workRepository;

  Future<WorkSearch?> invoke({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    return await _workRepository.searchWorksByTitleOrAuthor(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
  }
}