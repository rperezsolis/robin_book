import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

/// Use case for retrieving an author.
class GetAuthorUseCase {
  final WorkRepository _workRepository;

  GetAuthorUseCase({
    required WorkRepository workRepository
  }) : _workRepository = workRepository;

  /// Returns an [Author] related to the [key].
  Future<Author?> invoke({
    required String key,
  }) async {
    return await _workRepository.getAuthor(key: key);
  }
}