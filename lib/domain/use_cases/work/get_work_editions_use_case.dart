import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

class GetWorkEditionsUseCase {
  final WorkRepository _workRepository;

  GetWorkEditionsUseCase({required workRepository})
      : _workRepository = workRepository;

  Future<WorkEditions?> invoke({
    required String key,
    required int limit,
    required int offset
  }) async {
    return await _workRepository.getWorkEditions(
        key: key,
        limit: limit,
        offset: offset
    );
  }
}