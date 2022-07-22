import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

class GetAuthorUseCase {
  final WorkRepository _workRepository;

  GetAuthorUseCase({required workRepository})
      : _workRepository = workRepository;

  Future<Author?> invoke({
    required String key,
  }) async {
    return await _workRepository.getAuthor(key: key);
  }
}