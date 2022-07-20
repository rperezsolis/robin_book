import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/book_repository.dart';

class GetWorkUseCase {
  final BookRepository _bookRepository;

  GetWorkUseCase({required bookRepository})
      : _bookRepository = bookRepository;

  Future<Work?> invoke({
    required String key,
  }) async {
    return await _bookRepository.getWork(key: key);
  }
}