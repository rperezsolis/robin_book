import 'package:flutter/foundation.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/use_cases/favorite/add_favorite_work_use_case.dart';
import 'package:robin_book/domain/use_cases/favorite/delete_favorite_work_use_case.dart';
import 'package:robin_book/domain/use_cases/favorite/get_favorite_work_use_case.dart';

class FavoriteWorkProvider extends ChangeNotifier {
  final AddFavoriteWorkUseCase _addFavoriteWorkUseCase;
  final DeleteFavoriteWorkUseCase _deleteFavoriteWorkUseCase;
  final GetFavoriteWorkUseCase _getFavoriteWorkUseCase;

  FavoriteWork? _currentFavoriteWork;
  FavoriteWork? get currentFavoriteWork => _currentFavoriteWork;

  String? _snackBarMessage;
  String? get snackBarMessage => _snackBarMessage;

  FavoriteWorkProvider({
    required AddFavoriteWorkUseCase addFavoriteWorkUseCase,
    required DeleteFavoriteWorkUseCase deleteFavoriteWorkUseCase,
    required GetFavoriteWorkUseCase getFavoriteWorkUseCase
  }) : _addFavoriteWorkUseCase = addFavoriteWorkUseCase,
        _deleteFavoriteWorkUseCase = deleteFavoriteWorkUseCase,
        _getFavoriteWorkUseCase = getFavoriteWorkUseCase;

  Future<void> getFavoriteWork({
    required String key
  }) async {
    _currentFavoriteWork = await _getFavoriteWork(key: key);
    notifyListeners();
  }

  Future<FavoriteWork?> _getFavoriteWork({
    required String key
  }) async {
    return await _getFavoriteWorkUseCase.invoke(key: key);
  }

  Future<void> addOrDeleteFavoriteWork({
    required Work work
  }) async {
    _currentFavoriteWork = await _getFavoriteWork(key: work.key);
    if (_currentFavoriteWork == null) {
      int? id = await _addFavoriteWork(work: work);
      if (id != null) {
        _snackBarMessage = 'Book added to favorites';
      }
    } else {
      int? deletedItems = await _deleteFavoriteWork(key: work.key);
      if (deletedItems != null) {
        _snackBarMessage = 'Book deleted from favorites';
      }
    }
    _currentFavoriteWork = await _getFavoriteWork(key: work.key);
    notifyListeners();
  }

  Future<int?> _addFavoriteWork({
    required Work work
  }) async {
    return await _addFavoriteWorkUseCase.invoke(work: work);
  }

  Future<int?> _deleteFavoriteWork({
    required String key
  }) async {
    return await _deleteFavoriteWorkUseCase.invoke(key: key);
  }

  void resetSnackBarMessage() {
    _snackBarMessage = null;
  }
}