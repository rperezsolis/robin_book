import 'package:flutter/material.dart';
import 'package:robin_book/ui/route_manager.dart';
import 'package:robin_book/ui/screens/book_search/book_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robin Book',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: BookSearchScreen.routeName,
      onGenerateRoute: RouteManager().getRoutes,
    );
  }
}
