import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

/// Use case for retrieving the work editions of a work.
class GetWorkEditionsUseCase {
  final WorkRepository _workRepository;

  GetWorkEditionsUseCase({
    required WorkRepository workRepository
  }) : _workRepository = workRepository;

  /// Returns the [WorkEditions] related to the [key], [limit], and [offset].
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