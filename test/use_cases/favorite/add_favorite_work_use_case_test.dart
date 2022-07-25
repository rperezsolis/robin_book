import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';
import 'package:robin_book/domain/use_cases/favorite/add_favorite_work_use_case.dart';

class MockFavoriteWorkRepository extends Mock implements FavoriteWorkRepository {}

main() {
  final MockFavoriteWorkRepository repository = MockFavoriteWorkRepository();
  final AddFavoriteWorkUseCase useCase = AddFavoriteWorkUseCase(
      favoriteWorkRepository: repository);
  final Work work = Work(key: '1234', title: 'Test Book');
  const int id = 1;

  test('add favorite work', () async {
    when(() => repository.addFavoriteWork(work: work)).thenAnswer((invocation) async => id);
    int? addedBookId = await useCase.invoke(work: work);

    verify(() => repository.addFavoriteWork(work: work));
    expect(addedBookId, 1);
  });
}