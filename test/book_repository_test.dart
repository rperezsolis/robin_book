import 'package:flutter_test/flutter_test.dart';
import 'package:robin_book/data/data_source/network_data_source.dart';
import 'package:robin_book/data/repository/book_repository.dart';
import 'package:robin_book/domain/author/author.dart';
import 'package:robin_book/domain/edition/work_editions.dart';
import 'package:robin_book/domain/work/work.dart';
import 'package:robin_book/domain/work_search/work_search.dart';

void main() {
  group('Book Repository', () {
    test('Function searchWorksByTitleOrAuthor returns WorkSearch object', () async {
      final bookRepository = BookRepository(networkDataSource: NetworkDataSource());
      WorkSearch? workSearch = await bookRepository.searchWorksByTitleOrAuthor(
          keyword: 'The little prince', limit: 20, offset: 0);
      expect(workSearch, isA<WorkSearch>());
    });
  });
  test('Function getWork returns Work object', () async {
    final bookRepository = BookRepository(networkDataSource: NetworkDataSource());
    Work? work = await bookRepository.getWork(key: '/works/OL10278W');
    expect(work, isA<Work>());
  });
  test('Function getWorkEditions returns WorkEditions object', () async {
    final bookRepository = BookRepository(networkDataSource: NetworkDataSource());
    WorkEditions? workEditions = await bookRepository.getWorkEditions(
        key: '/works/OL10278W', limit: 20, offset: 0);
    expect(workEditions, isA<WorkEditions>());
  });
  test('Function getAuthor returns Author object', () async {
    final bookRepository = BookRepository(networkDataSource: NetworkDataSource());
    Author? author = await bookRepository.getAuthor(
        key: '/authors/OL31901A');
    expect(author, isA<Author>());
  });
}