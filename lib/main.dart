import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/data/data_source/network_data_source.dart';
import 'package:robin_book/data/data_source/work_database.dart';
import 'package:robin_book/data/repository/book_repository.dart';
import 'package:robin_book/ui/route_manager.dart';
import 'package:robin_book/ui/screens/book_search/book_search_screen.dart';
import 'package:robin_book/ui/state_management/book_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<BookProvider>(
          create: (BuildContext context) => BookProvider(
            bookRepository: BookRepository(
                networkDataSource: NetworkDataSource()
            )
          ),
        ),
        Provider<WorkDatabase>(
          create: (context) => WorkDatabase(),
          dispose: (context, db) => db.close(),
        )
      ],
      child: MaterialApp(
        title: 'Robin Book',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: BookSearchScreen.routeName,
        onGenerateRoute: RouteManager().getRoutes,
      ),
    );
  }
}
