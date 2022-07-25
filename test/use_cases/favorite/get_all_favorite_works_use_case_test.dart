import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';
import 'package:robin_book/domain/use_cases/favorite/get_all_favorite_works_use_case.dart';

class MockFavoriteWorkRepository extends Mock implements FavoriteWorkRepository {}

main() {
  final MockFavoriteWorkRepository repository = MockFavoriteWorkRepository();
  final GetAllFavoriteWorksUseCase useCase = GetAllFavoriteWorksUseCase(
      favoriteWorkRepository: repository);
  final List<FavoriteWork> works = [
    FavoriteWork(id: 1, key: '1234', work: Work(key: '1234', title: 'Test Book')),
    FavoriteWork(id: 2, key: '1234', work: Work(key: '1234', title: 'Test Book 2'))
  ];
  const int id = 1;

  test('get all favorite works', () async {
    when(() => repository.getAllFavoriteWorks()).thenAnswer((invocation) async => works);
    List<FavoriteWork> favoriteWorks = await useCase.invoke();

    verify(() => repository.getAllFavoriteWorks());
    expect(favoriteWorks, works);
  });
}