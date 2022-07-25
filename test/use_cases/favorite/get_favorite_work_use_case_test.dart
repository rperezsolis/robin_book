import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';
import 'package:robin_book/domain/use_cases/favorite/get_favorite_work_use_case.dart';

class MockFavoriteWorkRepository extends Mock implements FavoriteWorkRepository {}

main() {
  final MockFavoriteWorkRepository repository = MockFavoriteWorkRepository();
  final GetFavoriteWorkUseCase useCase = GetFavoriteWorkUseCase(
      favoriteWorkRepository: repository);
  final FavoriteWork work = FavoriteWork(id: 1, key: '1234',
      work: Work(key: '1234', title: 'Test Book'));
  const String key = '1234';

  test('get favorite work', () async {
    when(() => repository.getFavoriteWork(key: key)).thenAnswer((invocation) async => work);
    FavoriteWork? favoriteWork = await useCase.invoke(key: key);

    verify(() => repository.getFavoriteWork(key: key));
    expect(favoriteWork, work);
  });
}