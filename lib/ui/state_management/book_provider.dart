import 'package:flutter/foundation.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work/work_author.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';
import 'package:robin_book/domain/use_cases/get_author_use_case.dart';
import 'package:robin_book/domain/use_cases/get_work_editions_use_case.dart';
import 'package:robin_book/domain/use_cases/get_work_use_case.dart';
import 'package:robin_book/domain/use_cases/search_works_by_title_or_author_use_case.dart';

class BookProvider extends ChangeNotifier {
  static const workPageSize = 20;
  static const editionPageSize = 10;

  final GetAuthorUseCase _getAuthorUseCase;
  final GetWorkEditionsUseCase _getWorkEditionsUseCase;
  final GetWorkUseCase _getWorkUseCase;
  final SearchBooksByTitleOrAuthorUseCase _searchBooksByTitleOrAuthorUseCase;

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

  BookProvider({
    required GetAuthorUseCase getAuthorUseCase,
    required GetWorkEditionsUseCase getWorkEditionsUseCase,
    required GetWorkUseCase getWorkUseCase,
    required SearchBooksByTitleOrAuthorUseCase searchBooksByTitleOrAuthorUseCase
  })
      : _getAuthorUseCase = getAuthorUseCase,
        _getWorkEditionsUseCase = getWorkEditionsUseCase,
        _getWorkUseCase = getWorkUseCase,
        _searchBooksByTitleOrAuthorUseCase = searchBooksByTitleOrAuthorUseCase;

  searchWorksByTitleOrAuthor({
    required bool isFirstPage,
    required String keyword
  }) async {
    lastKeyword = keyword;
    if (isFirstPage) {
      reset();
      _isLoadingFirstPage = true;
      notifyListeners();
      _workSearch = await _searchBooksByTitleOrAuthorUseCase.invoke(
          keyword: keyword,
          limit: workPageSize,
          offset: 0
      );
    } else {
      _isLoadingNewPage = true;
      notifyListeners();
      WorkSearch? newWorkSearch = await _searchBooksByTitleOrAuthorUseCase.invoke(
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

  getWorkEditions({
    required String key,
    required bool isFirstPage
  }) async {
    if (isFirstPage) {
      _currentWorkEditions = await _getWorkEditionsUseCase.invoke(
          key: key,
          limit: editionPageSize,
          offset: 0
      );
    } else {
      WorkEditions? newWorkEditions = await _getWorkEditionsUseCase.invoke(
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

  reset() {
    _currentWork = null;
    _currentWorkEditions = null;
    _currentAuthors = null;
    _workPageLimit = workPageSize;
    _workPageOffset = 0;
    _workEditionsPageLimit = editionPageSize;
    _workEditionsPageOffset = 0;
    notifyListeners();
  }
}