import 'package:robin_book/data/data_source/network_data_source.dart';
import 'package:robin_book/domain/work_search/work_search.dart';

class BookRepository {
  final NetworkDataSource _networkDataSource;

  BookRepository({required networkDataSource})
      : _networkDataSource = networkDataSource;

  Future<WorkSearch?> searchWorksByTitleOrAuthor({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    return _networkDataSource.searchWorksByTitleOrAuthor(
      keyword: keyword,
      limit: limit,
      offset: offset
    );
  }
}