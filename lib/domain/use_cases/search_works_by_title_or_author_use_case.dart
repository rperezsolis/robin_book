import 'package:robin_book/domain/models/work_search/work_search.dart';
import 'package:robin_book/domain/repository/book_repository.dart';

class SearchBooksByTitleOrAuthorUseCase {
  final BookRepository _bookRepository;

  SearchBooksByTitleOrAuthorUseCase({required bookRepository})
      : _bookRepository = bookRepository;

  Future<WorkSearch?> invoke({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    return await _bookRepository.searchWorksByTitleOrAuthor(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
  }
}