import 'package:flutter/foundation.dart';
import 'package:robin_book/data/repository/book_repository.dart';
import 'package:robin_book/domain/author/author.dart';
import 'package:robin_book/domain/edition/work_editions.dart';
import 'package:robin_book/domain/work/work.dart';
import 'package:robin_book/domain/work/work_author.dart';
import 'package:robin_book/domain/work_search/work_search.dart';

class BookProvider extends ChangeNotifier {
  static const workPageSize = 20;
  static const editionPageSize = 10;

  final BookRepository _bookRepository;

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

  BookProvider({required bookRepository})
      : _bookRepository = bookRepository;

  searchWorksByTitleOrAuthor({
    required String keyword,
    required bool isFirstPage
  }) async {
    lastKeyword = keyword;
    if (isFirstPage) {
      _isLoadingFirstPage = true;
      notifyListeners();
      _workSearch = await _bookRepository.searchWorksByTitleOrAuthor(
          keyword: keyword,
          limit: workPageSize,
          offset: 0
      );
    } else {
      _isLoadingNewPage = true;
      notifyListeners();
      WorkSearch? newWorkSearch = await _bookRepository.searchWorksByTitleOrAuthor(
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
    _currentWork = await _bookRepository.getWork(key: key);
    _currentAuthors = await _getAuthors();
    _isLoadingWork = false;
    notifyListeners();
  }

  getWorkEditions({
    required String key,
    required bool isFirstPage
  }) async {
    if (isFirstPage) {
      _currentWorkEditions = await _bookRepository.getWorkEditions(
          key: key,
          limit: editionPageSize,
          offset: 0
      );
    } else {
      WorkEditions? newWorkEditions = await _bookRepository.getWorkEditions(
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
        Author? author = await _bookRepository.getAuthor(key: workAuthor.authorKey.key);
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
    notifyListeners();
  }
}