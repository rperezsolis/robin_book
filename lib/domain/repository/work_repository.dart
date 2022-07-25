import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/data/data_source/remote/remote_data_source.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';

/// Class for handle [Work] related data operations.
class WorkRepository {
  final RemoteDataSource _remoteDataSource;
  final WorkDatabase _workDatabase;

  WorkRepository({
    required RemoteDataSource remoteDataSource,
    required WorkDatabase workDatabase
  }) : _workDatabase = workDatabase,
        _remoteDataSource = remoteDataSource;

  /// Returns a [WorkSearch] related to the [keyword], [limit], and [offset]
  /// from the cache if any.
  Future<WorkSearch?> searchWorksByTitleOrAuthorFromCache({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    return await _workDatabase.getWorkSearch(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
  }

  /// Returns a [WorkSearch] related to the [keyword], [limit], and [offset]
  /// from the network if any.
  Future<WorkSearch?> searchWorksByTitleOrAuthorFromNetwork({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    return await _remoteDataSource.searchWorksByTitleOrAuthor(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
  }

  /// Updates the cached value for the [workSearch]. [keyword], [limit], and
  /// [offset] are necessary to identify the saved value.
  Future<void> updateLocalWorkSearch({
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

  /// Returns a [Work] related to the [key].
  Future<Work?> getWork({
    required String key,
  }) async {
    return await _remoteDataSource.getWork(key: key);
  }

  /// Returns the [WorkEditions] related to the [key], [limit], and [offset].
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

  /// Returns an [Author] related to the [key].
  Future<Author?> getAuthor({
    required String key,
  }) async {
    return await _remoteDataSource.getAuthor(key: key);
  }
}