import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/work_repository.dart';

class GetWorkUseCase {
  final WorkRepository _workRepository;

  GetWorkUseCase({required workRepository})
      : _workRepository = workRepository;

  Future<Work?> invoke({
    required String key,
  }) async {
    return await _workRepository.getWork(key: key);
  }
}