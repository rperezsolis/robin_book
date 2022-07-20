import 'package:flutter_test/flutter_test.dart';
import 'package:robin_book/data/data_source/remote/remote_data_source.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';

void main() {
  group('Network Data Source', () {
    test('Function searchWorksByTitleOrAuthor returns WorkSearch object', () async {
      final networkDataSource = RemoteDataSource();
      WorkSearch? workSearch = await networkDataSource.searchWorksByTitleOrAuthor(
          keyword: 'The little prince', limit: 20, offset: 0);
      expect(workSearch, isA<WorkSearch>());
    });
    test('Function getWork returns Work object', () async {
      final networkDataSource = RemoteDataSource();
      Work? work = await networkDataSource.getWork(key: 'OL10278W');
      expect(work, isA<Work>());
    });
    test('Function getWorkEditions returns WorkEditions object', () async {
      final networkDataSource = RemoteDataSource();
      WorkEditions? workEditions = await networkDataSource.getWorkEditions(
          key: 'OL10278W', limit: 20, offset: 0);
      expect(workEditions, isA<WorkEditions>());
    });
    test('Function getAuthor returns Author object', () async {
      final networkDataSource = RemoteDataSource();
      Author? author = await networkDataSource.getAuthor(
          key: 'OL31901A');
      expect(author, isA<Author>());
    });
  });
}