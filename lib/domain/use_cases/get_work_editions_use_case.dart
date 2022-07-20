import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/repository/book_repository.dart';

class GetWorkEditionsUseCase {
  final BookRepository _bookRepository;

  GetWorkEditionsUseCase({required bookRepository})
      : _bookRepository = bookRepository;

  Future<WorkEditions?> invoke({
    required String key,
    required int limit,
    required int offset
  }) async {
    return await _bookRepository.getWorkEditions(
        key: key,
        limit: limit,
        offset: offset
    );
  }
}