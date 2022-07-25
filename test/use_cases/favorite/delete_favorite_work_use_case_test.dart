import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';
import 'package:robin_book/domain/use_cases/favorite/delete_favorite_work_use_case.dart';

class MockFavoriteWorkRepository extends Mock implements FavoriteWorkRepository {}

main() {
  final MockFavoriteWorkRepository repository = MockFavoriteWorkRepository();
  final DeleteFavoriteWorkUseCase useCase = DeleteFavoriteWorkUseCase(
      favoriteWorkRepository: repository);
  const String key = '1234';
  const int deletedCount = 1;

  test('delete favorite work', () async {
    when(() => repository.deleteFavoriteWork(key: key)).thenAnswer((invocation) async => deletedCount);
    int? deletedBookCount = await useCase.invoke(key: key);

    verify(() => repository.deleteFavoriteWork(key: key));
    expect(deletedBookCount, 1);
  });
}