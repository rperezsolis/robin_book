import 'package:robin_book/data/data_source/network_data_source.dart';
import 'package:robin_book/domain/author/author.dart';
import 'package:robin_book/domain/edition/work_editions.dart';
import 'package:robin_book/domain/work/work.dart';
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
    return await _networkDataSource.searchWorksByTitleOrAuthor(
      keyword: keyword,
      limit: limit,
      offset: offset
    );
  }

  Future<Work?> getWork({
    required String key,
  }) async {
    return await _networkDataSource.getWork(key: key);
  }

  Future<WorkEditions?> getWorkEditions({
    required String key,
    required int limit,
    required int offset
  }) async {
    return await _networkDataSource.getWorkEditions(
      key: key,
      limit: limit,
      offset: offset
    );
  }

  Future<Author?> getAuthor({
    required String key,
  }) async {
    return await _networkDataSource.getAuthor(key: key);
  }
}