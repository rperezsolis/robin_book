import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

/// Use case for retrieving a work.
class GetWorkUseCase {
  final WorkRepository _workRepository;

  GetWorkUseCase({
    required WorkRepository workRepository
  }) : _workRepository = workRepository;

  /// Returns a [Work] related to the [key].
  Future<Work?> invoke({
    required String key,
  }) async {
    return await _workRepository.getWork(key: key);
  }
}