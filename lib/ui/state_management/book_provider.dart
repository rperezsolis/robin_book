import 'package:flutter/foundation.dart';
import 'package:robin_book/data/repository/book_repository.dart';
import 'package:robin_book/domain/work_search/work_search.dart';

class BookProvider extends ChangeNotifier {
  static const pageSize = 20;

  final BookRepository _bookRepository;

  WorkSearch? _workSearch;
  WorkSearch? get workSearch => _workSearch;

  bool _isLoadingFirstPage = false;
  bool get isLoadingFirstPage => _isLoadingFirstPage;

  bool _isLoadingNewPage = false;
  bool get isLoadingNewPage => _isLoadingNewPage;

  int _limit = pageSize;
  int _offset = 0;

  String lastKeyword = '';

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
          limit: pageSize,
          offset: 0
      );
    } else {
      _isLoadingNewPage = true;
      notifyListeners();
      WorkSearch? newWorkSearch = await _bookRepository.searchWorksByTitleOrAuthor(
          keyword: keyword,
          limit: _limit + pageSize,
          offset: _offset + pageSize
      );
      if (newWorkSearch != null && newWorkSearch.items.isNotEmpty) {
        _workSearch?.items += newWorkSearch.items;
        _limit += pageSize;
        _offset += pageSize;
      }
    }
    _isLoadingFirstPage = false;
    _isLoadingNewPage = false;
    notifyListeners();
  }
}