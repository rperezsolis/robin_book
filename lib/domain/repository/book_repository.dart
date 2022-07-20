import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/data/data_source/remote/remote_data_source.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';

class BookRepository {
  final RemoteDataSource _remoteDataSource;
  final WorkDatabase _workDatabase;

  BookRepository({
    required RemoteDataSource remoteDataSource,
    required WorkDatabase workDatabase
  }) : _workDatabase = workDatabase,
        _remoteDataSource = remoteDataSource;

  Future<WorkSearch?> searchWorksByTitleOrAuthor({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    WorkSearch? localWorkSearch = await _workDatabase.getWorkSearch(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
    if (localWorkSearch != null) {
      _updateLocalWorkSearch(
          keyword: keyword,
          limit: limit,
          offset: offset,
      );
      return localWorkSearch;
    } else {
      WorkSearch? remoteWorkSearch = await _remoteDataSource.searchWorksByTitleOrAuthor(
          keyword: keyword,
          limit: limit,
          offset: offset
      );
      await _updateLocalWorkSearch(
          keyword: keyword,
          limit: limit,
          offset: offset,
          workSearch: remoteWorkSearch
      );
      return remoteWorkSearch;
    }
  }

  Future<void> _updateLocalWorkSearch({
    required String keyword,
    required int limit,
    required int offset,
    WorkSearch? workSearch
  }) async {
    WorkSearch? remoteWorkSearch;
    if (workSearch == null) {
      remoteWorkSearch = await _remoteDataSource.searchWorksByTitleOrAuthor(
          keyword: keyword,
          limit: limit,
          offset: offset
      );
    } else {
      remoteWorkSearch = workSearch;
    }
    if (remoteWorkSearch != null) {
      await _workDatabase.addWorkSearch(
          keyword: keyword,
          limit: limit,
          offset: offset,
          workSearch: remoteWorkSearch
      );
    }
  }

  Future<Work?> getWork({
    required String key,
  }) async {
    return await _remoteDataSource.getWork(key: key);
  }

  Future<WorkEditions?> getWorkEditions({
    required String key,
    required int limit,
    required int offset
  }) async {
    return await _remoteDataSource.getWorkEditions(
      key: key,
      limit: limit,
      offset: offset
    );
  }

  Future<Author?> getAuthor({
    required String key,
  }) async {
    return await _remoteDataSource.getAuthor(key: key);
  }
}