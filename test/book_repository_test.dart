import 'package:flutter_test/flutter_test.dart';
import 'package:robin_book/data/data_source/remote/remote_data_source.dart';
import 'package:robin_book/domain/repository/book_repository.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';

void main() {
  group('Book Repository', () {
    test('Function searchWorksByTitleOrAuthor returns WorkSearch object', () async {
      final bookRepository = BookRepository(remoteDataSource: RemoteDataSource());
      WorkSearch? workSearch = await bookRepository.searchWorksByTitleOrAuthor(
          keyword: 'The little prince', limit: 20, offset: 0);
      expect(workSearch, isA<WorkSearch>());
    });
  });
  test('Function getWork returns Work object', () async {
    final bookRepository = BookRepository(remoteDataSource: RemoteDataSource());
    Work? work = await bookRepository.getWork(key: '/works/OL10278W');
    expect(work, isA<Work>());
  });
  test('Function getWorkEditions returns WorkEditions object', () async {
    final bookRepository = BookRepository(remoteDataSource: RemoteDataSource());
    WorkEditions? workEditions = await bookRepository.getWorkEditions(
        key: '/works/OL10278W', limit: 20, offset: 0);
    expect(workEditions, isA<WorkEditions>());
  });
  test('Function getAuthor returns Author object', () async {
    final bookRepository = BookRepository(remoteDataSource: RemoteDataSource());
    Author? author = await bookRepository.getAuthor(
        key: '/authors/OL31901A');
    expect(author, isA<Author>());
  });
}