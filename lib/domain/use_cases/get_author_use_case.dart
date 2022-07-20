import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/repository/book_repository.dart';

class GetAuthorUseCase {
  final BookRepository _bookRepository;

  GetAuthorUseCase({required bookRepository})
      : _bookRepository = bookRepository;

  Future<Author?> invoke({
    required String key,
  }) async {
    return await _bookRepository.getAuthor(key: key);
  }
}