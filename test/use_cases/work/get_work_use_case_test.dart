import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/work_repository.dart';
import 'package:robin_book/domain/use_cases/work/get_work_use_case.dart';

class MockWorkRepository extends Mock implements WorkRepository {}

main() {
  final MockWorkRepository repository = MockWorkRepository();
  final GetWorkUseCase useCase = GetWorkUseCase(workRepository: repository);
  const String key = '1234';
  final Work testWork = Work(key: key, title: 'Test Title');

  test('get work', () async {
    when(() => repository.getWork(key: key)).thenAnswer((invocation) async => testWork);
    final Work? work = await useCase.invoke(key: key);

    verify(() => repository.getWork(key: key));
    expect(work?.key, key);
  });
}