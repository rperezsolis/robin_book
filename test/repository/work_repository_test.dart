import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/data/data_source/remote/remote_data_source.dart';
import 'package:robin_book/domain/models/edition/edition.dart';
import 'package:robin_book/domain/models/work_search/work_search_item.dart';
import 'package:robin_book/domain/repository/work_repository.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}
class MockWorkDatabase extends Mock implements WorkDatabase {}

void main() {
  final MockRemoteDataSource remoteDataSource = MockRemoteDataSource();
  final MockWorkDatabase localDatasource = MockWorkDatabase();
  final workRepository = WorkRepository(
      remoteDataSource: remoteDataSource,
      workDatabase: localDatasource
  );
  const String keyword = 'Test keyword';
  const int limit = 20;
  const int offset = 0;
  const String testTitle1 = 'Test Title';
  const String testTitle2 = 'Test Title 2';
  final WorkSearch testWorkSearch = WorkSearch(items: [
    WorkSearchItem(key: '1234', title: testTitle1),
    WorkSearchItem(key: '1234', title: testTitle2)
  ]);
  const String key = '1234';
  final Work testWork = Work(key: key, title: testTitle1);
  final WorkEditions testWorkEditions = WorkEditions(items: [Edition(title: 'Test tittle')]);
  const String testName = 'Test Name';
  final Author testAuthor = Author(key: key, name: testName);

  group('Work Repository', () {
    test('search works from cache', () async {
      when(() => localDatasource.getWorkSearch(keyword: keyword, limit: limit, offset: offset))
          .thenAnswer((invocation) async => testWorkSearch);
      WorkSearch? workSearch = await workRepository.searchWorksByTitleOrAuthorFromCache(
          keyword: keyword, limit: limit, offset: offset);

      verify(() => localDatasource.getWorkSearch(keyword: keyword, limit: limit, offset: offset));
      expect(workSearch?.items.length, 2);
      expect(workSearch?.items[0].title, testTitle1);
      expect(workSearch?.items[1].title, testTitle2);
    });

    test('search works from network', () async {
      when(() => remoteDataSource.searchWorksByTitleOrAuthor(keyword: keyword, limit: limit, offset: offset))
          .thenAnswer((invocation) async => testWorkSearch);
      WorkSearch? workSearch = await workRepository.searchWorksByTitleOrAuthorFromNetwork(
          keyword: keyword, limit: limit, offset: offset);

      verify(() => remoteDataSource.searchWorksByTitleOrAuthor(keyword: keyword, limit: limit, offset: offset));
      expect(workSearch?.items.length, 2);
      expect(workSearch?.items[0].title, testTitle1);
      expect(workSearch?.items[1].title, testTitle2);
    });

    test('get work', () async {
      when(() => remoteDataSource.getWork(key: key)).thenAnswer((invocation) async => testWork);
      Work? work = await workRepository.getWork(key: key);

      verify(() => remoteDataSource.getWork(key: key));
      expect(work?.title, testWork.title);
    });

    test('get work editions', () async {
      when(() => remoteDataSource.getWorkEditions(key: key, limit: limit, offset: offset))
          .thenAnswer((invocation) async => testWorkEditions);
      WorkEditions? workEditions = await workRepository.getWorkEditions(
          key: key, limit: limit, offset: offset);

      verify(() => remoteDataSource.getWorkEditions(key: key, limit: limit, offset: offset));
      expect(workEditions?.items.length, 1);
    });

    test('get author', () async {
      when(() => remoteDataSource.getAuthor(key: key)).thenAnswer((invocation) async => testAuthor);
      Author? author = await workRepository.getAuthor(key: key);

      verify(() => remoteDataSource.getAuthor(key: key));
      expect(author?.name, testName);
    });
  });
}