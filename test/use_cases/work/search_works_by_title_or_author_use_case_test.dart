import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';
import 'package:robin_book/domain/models/work_search/work_search_item.dart';
import 'package:robin_book/domain/repository/work_repository.dart';
import 'package:robin_book/domain/use_cases/work/search_works_by_title_or_author_use_case.dart';

class MockWorkRepository extends Mock implements WorkRepository {}

main() {
  final MockWorkRepository repository = MockWorkRepository();
  final SearchWorksByTitleOrAuthorUseCase useCase = SearchWorksByTitleOrAuthorUseCase(workRepository: repository);
  const String keyword = 'Test keyword';
  const int limit = 20;
  const int offset = 0;
  const String testTitle1 = 'Test Title';
  const String testTitle2 = 'Test Title 2';
  final WorkSearch testWorkSearch = WorkSearch(items: [
    WorkSearchItem(key: '1234', title: testTitle1),
    WorkSearchItem(key: '1234', title: testTitle2)
  ]);

  group('search works from cache and from network', () {
    test('search works from cache', () async {
      when(() => repository.searchWorksByTitleOrAuthorFromCache(keyword: keyword, limit: limit, offset: offset))
          .thenAnswer((invocation) async => testWorkSearch);
      when(() => repository.updateLocalWorkSearch(keyword: keyword, limit: limit, offset: offset))
          .thenAnswer((invocation) async {});
      final WorkSearch? workSearch = await useCase.invoke(keyword: keyword, limit: limit, offset: offset);

      verify(() => repository.searchWorksByTitleOrAuthorFromCache(keyword: keyword, limit: limit, offset: offset));
      verify(() => repository.updateLocalWorkSearch(keyword: keyword, limit: limit, offset: offset));
      expect(workSearch?.items.length, 2);
      expect(workSearch?.items[0].title, testTitle1);
      expect(workSearch?.items[1].title, testTitle2);
    });

    test('search works from network', () async {
      when(() => repository.searchWorksByTitleOrAuthorFromCache(keyword: keyword, limit: limit, offset: offset))
          .thenAnswer((invocation) async => null);
      when(() => repository.searchWorksByTitleOrAuthorFromNetwork(keyword: keyword, limit: limit, offset: offset))
          .thenAnswer((invocation) async => testWorkSearch);
      when(() => repository.updateLocalWorkSearch(keyword: keyword, limit: limit, offset: offset, workSearch: testWorkSearch))
          .thenAnswer((invocation) async {});
      final WorkSearch? workSearch = await useCase.invoke(keyword: keyword, limit: limit, offset: offset);

      verify(() => repository.searchWorksByTitleOrAuthorFromCache(keyword: keyword, limit: limit, offset: offset));
      verify(() => repository.searchWorksByTitleOrAuthorFromNetwork(keyword: keyword, limit: limit, offset: offset));
      verify(() => repository.updateLocalWorkSearch(keyword: keyword, limit: limit, offset: offset, workSearch: testWorkSearch));
      expect(workSearch?.items.length, 2);
      expect(workSearch?.items[0].title, testTitle1);
      expect(workSearch?.items[1].title, testTitle2);
    });
  });
}