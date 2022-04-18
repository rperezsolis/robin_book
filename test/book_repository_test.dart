import 'package:flutter_test/flutter_test.dart';
import 'package:robin_book/data/data_source/network_data_source.dart';
import 'package:robin_book/data/repository/book_repository.dart';
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
}