import 'package:flutter/foundation.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work/work_author.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';
import 'package:robin_book/domain/use_cases/work/get_author_use_case.dart';
import 'package:robin_book/domain/use_cases/work/get_work_editions_use_case.dart';
import 'package:robin_book/domain/use_cases/work/get_work_use_case.dart';
import 'package:robin_book/domain/use_cases/work/search_works_by_title_or_author_use_case.dart';

/// Class for managing the state of works.
class WorkProvider extends ChangeNotifier {
  static const workPageSize = 20;
  static const editionPageSize = 10;

  final GetAuthorUseCase _getAuthorUseCase;
  final GetWorkEditionsUseCase _getWorkEditionsUseCase;
  final GetWorkUseCase _getWorkUseCase;
  final SearchWorksByTitleOrAuthorUseCase _searchWorksByTitleOrAuthorUseCase;

  WorkSearch? _workSearch;
  WorkSearch? get workSearch => _workSearch;

  bool _isLoadingFirstPage = false;
  bool get isLoadingFirstPage => _isLoadingFirstPage;

  bool _isLoadingNewPage = false;
  bool get isLoadingNewPage => _isLoadingNewPage;

  bool _isLoadingWork = false;
  bool get isLoadingWork => _isLoadingWork;

  int _workPageLimit = workPageSize;
  int _workPageOffset = 0;
  int _workEditionsPageLimit = editionPageSize;
  int _workEditionsPageOffset = 0;

  String lastKeyword = '';

  Work? _currentWork;
  Work? get currentWork => _currentWork;

  List<Author>? _currentAuthors;
  List<Author>? get currentAuthors => _currentAuthors;

  WorkEditions? _currentWorkEditions;
  WorkEditions? get currentWorkEditions => _currentWorkEditions;

  WorkProvider({
    required GetAuthorUseCase getAuthorUseCase,
    required GetWorkEditionsUseCase getWorkEditionsUseCase,
    required GetWorkUseCase getWorkUseCase,
    required SearchWorksByTitleOrAuthorUseCase searchWorksByTitleOrAuthorUseCase
  })
      : _getAuthorUseCase = getAuthorUseCase,
        _getWorkEditionsUseCase = getWorkEditionsUseCase,
        _getWorkUseCase = getWorkUseCase,
        _searchWorksByTitleOrAuthorUseCase = searchWorksByTitleOrAuthorUseCase;

  /// Returns a [WorkSearch] related to the [keyword], [limit], and [offset].
  /// Handles the paging logic.
  Future<void> searchWorksByTitleOrAuthor({
    required bool isFirstPage,
    required String keyword
  }) async {
    lastKeyword = keyword;
    if (isFirstPage) {
      resetWorks();
      _isLoadingFirstPage = true;
      notifyListeners();
      _workSearch = await _searchWorksByTitleOrAuthor(
          keyword: keyword,
          limit: workPageSize,
          offset: 0
      );
    } else {
      _isLoadingNewPage = true;
      notifyListeners();
      WorkSearch? newWorkSearch = await _searchWorksByTitleOrAuthor(
          keyword: keyword,
          limit: _workPageLimit + workPageSize,
          offset: _workPageOffset + workPageSize
      );
      if (newWorkSearch != null && newWorkSearch.items.isNotEmpty) {
        _workSearch?.items += newWorkSearch.items;
        _workPageLimit += workPageSize;
        _workPageOffset += workPageSize;
      }
    }
    _isLoadingFirstPage = false;
    _isLoadingNewPage = false;
    notifyListeners();
  }

  /// Returns a [Work] related to the [key].
  getWork({
    required String key,
  }) async {
    _isLoadingWork = true;
    notifyListeners();
    _currentWork = await _getWorkUseCase.invoke(key: key);
    _currentAuthors = await _getAuthors();
    _isLoadingWork = false;
    notifyListeners();
  }

  /// Returns the [WorkEditions] related to the [key], [limit], and [offset].
  /// Handles the paging logic.
  getWorkEditions({
    required String key,
    required bool isFirstPage
  }) async {
    if (isFirstPage) {
      resetWorkEditions();
      _currentWorkEditions = await _getWorkEditions(
          key: key,
          limit: editionPageSize,
          offset: 0
      );
    } else {
      WorkEditions? newWorkEditions = await _getWorkEditions(
          key: key,
          limit: _workEditionsPageLimit + editionPageSize,
          offset: _workEditionsPageOffset + editionPageSize
      );
      if (newWorkEditions != null && newWorkEditions.items.isNotEmpty) {
        _currentWorkEditions?.items += newWorkEditions.items;
        _workEditionsPageLimit += editionPageSize;
        _workEditionsPageOffset += editionPageSize;
      }
    }
    notifyListeners();
  }

  Future<WorkSearch?> _searchWorksByTitleOrAuthor({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    return await _searchWorksByTitleOrAuthorUseCase.invoke(
        keyword: keyword,
        limit: limit,
        offset: offset
    );
  }

  Future<WorkEditions?> _getWorkEditions({
    required String key,
    required int limit,
    required int offset
  }) async {
    return await _getWorkEditionsUseCase.invoke(
        key: key,
        limit: limit,
        offset: offset
    );
  }

  Future<List<Author>?> _getAuthors() async {
    if(_currentWork?.authors != null) {
      List<Author> authors = [];
      for(WorkAuthor workAuthor in _currentWork!.authors!) {
        Author? author = await _getAuthorUseCase.invoke(key: workAuthor.authorKey.key);
        if (author != null) {
          authors.add(author);
        }
      }
      return authors;
    } else {
      return null;
    }
  }

  /// Resets the variables related to the works paging.
  resetWorks() {
    _currentWork = null;
    _currentWorkEditions = null;
    _currentAuthors = null;
    _workPageLimit = workPageSize;
    _workPageOffset = 0;
    _workEditionsPageLimit = editionPageSize;
    _workEditionsPageOffset = 0;
    notifyListeners();
  }

  /// Resets the variables related to the work editions paging.
  resetWorkEditions() {
    _currentWorkEditions = null;
    _workEditionsPageLimit = editionPageSize;
    _workEditionsPageOffset = 0;
    notifyListeners();
  }
}