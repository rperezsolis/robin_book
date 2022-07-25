import 'package:flutter/material.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/ui/screens/book_details/book_details_screen.dart';
import 'package:robin_book/ui/screens/book_search/book_search_screen.dart';
import 'package:robin_book/ui/screens/favorites/favorites_screen.dart';

/// This class contains the method necessary for handling the navigation
class RouteManager {
  static final RouteManager _singleton = RouteManager._internal();

  factory RouteManager() {
    return _singleton;
  }

  RouteManager._internal();

  /// This method is meant to be used as the navigation route handler, as a
  /// parameter for [MaterialApp.onGenerateRoute] in our [MaterialApp].
  Route<dynamic> getRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case BookSearchScreen.routeName:
        return MaterialPageRoute(builder: (_) => const BookSearchScreen());
      case BookDetailsScreen.routeName:
        return MaterialPageRoute(builder: (_) => BookDetailsScreen(
          work: args as Work,
        ));
      case FavoritesScreen.routeName:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      default:
        return MaterialPageRoute(builder: (_) => const BookSearchScreen());
    }
  }
}