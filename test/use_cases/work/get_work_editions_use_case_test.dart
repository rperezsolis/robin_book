import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/domain/models/edition/edition.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/repository/work_repository.dart';
import 'package:robin_book/domain/use_cases/work/get_work_editions_use_case.dart';

class MockWorkRepository extends Mock implements WorkRepository {}

main() {
  final MockWorkRepository repository = MockWorkRepository();
  final GetWorkEditionsUseCase useCase = GetWorkEditionsUseCase(workRepository: repository);
  const String key = '1234';
  const int limit = 20;
  const int offset = 0;
  final WorkEditions testWorkEditions = WorkEditions(items: [Edition(title: 'Test tittle')]);

  test('get work editions', () async {
    when(() => repository.getWorkEditions(key: key, limit: limit, offset: offset))
        .thenAnswer((invocation) async => testWorkEditions);
    final WorkEditions? workEditions = await useCase.invoke(key: key, limit: limit, offset: offset);

    verify(() => repository.getWorkEditions(key: key, limit: limit, offset: offset));
    expect(workEditions?.items.length, 1);
  });
}