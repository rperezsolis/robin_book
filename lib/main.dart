import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/data/data_source/remote/remote_data_source.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/repository/book_repository.dart';
import 'package:robin_book/domain/use_cases/get_author_use_case.dart';
import 'package:robin_book/domain/use_cases/get_work_editions_use_case.dart';
import 'package:robin_book/domain/use_cases/get_work_use_case.dart';
import 'package:robin_book/domain/use_cases/search_works_by_title_or_author_use_case.dart';
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
              getAuthorUseCase: GetAuthorUseCase(
                  bookRepository: BookRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              ),
              getWorkEditionsUseCase: GetWorkEditionsUseCase(
                  bookRepository: BookRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              ),
              getWorkUseCase: GetWorkUseCase(
                  bookRepository: BookRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              ),
              searchBooksByTitleOrAuthorUseCase: SearchBooksByTitleOrAuthorUseCase(
                  bookRepository: BookRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              )
          ),
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
