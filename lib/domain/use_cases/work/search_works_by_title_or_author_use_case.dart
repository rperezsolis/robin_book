import 'package:robin_book/domain/models/work_search/work_search.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

/// Use case for searching works by title or author based on user input.
class SearchWorksByTitleOrAuthorUseCase {
  final WorkRepository _workRepository;

  SearchWorksByTitleOrAuthorUseCase({
    required WorkRepository workRepository
  }) : _workRepository = workRepository;

  /// Returns a [WorkSearch] related to the [keyword], [limit], and [offset].
  Future<WorkSearch?> invoke({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    WorkSearch? localWorkSearch = await _workRepository.searchWorksByTitleOrAuthorFromCache(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
    if (localWorkSearch != null) {
      _workRepository.updateLocalWorkSearch(
        keyword: keyword,
        limit: limit,
        offset: offset,
      );
      return localWorkSearch;
    } else {
      WorkSearch? remoteWorkSearch = await _workRepository.searchWorksByTitleOrAuthorFromNetwork(
          keyword: keyword,
          limit: limit,
          offset: offset
      );
      if (remoteWorkSearch != null) {
        await _workRepository.updateLocalWorkSearch(
            keyword: keyword,
            limit: limit,
            offset: offset,
            workSearch: remoteWorkSearch
        );
      }
      return remoteWorkSearch;
    }
  }
}