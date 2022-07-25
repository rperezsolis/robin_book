import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/repository/work_repository.dart';
import 'package:robin_book/domain/use_cases/work/get_author_use_case.dart';

class MockWorkRepository extends Mock implements WorkRepository {}

main() {
  final MockWorkRepository repository = MockWorkRepository();
  final GetAuthorUseCase useCase = GetAuthorUseCase(workRepository: repository);
  const String key = '1234';
  final Author testAuthor = Author(key: key, name: 'Test Name');

  test('get author', () async {
    when(() => repository.getAuthor(key: key)).thenAnswer((invocation) async => testAuthor);
    Author? author = await useCase.invoke(key: key);

    verify(() => repository.getAuthor(key: key));
    expect(author?.key, key);
  });
}