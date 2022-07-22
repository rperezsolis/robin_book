import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/data/data_source/remote/remote_data_source.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/repository/favorite_work_repository.dart';
import 'package:robin_book/domain/repository/work_repository.dart';
import 'package:robin_book/domain/use_cases/favorite/add_favorite_work_use_case.dart';
import 'package:robin_book/domain/use_cases/favorite/delete_favorite_work_use_case.dart';
import 'package:robin_book/domain/use_cases/favorite/get_favorite_work_use_case.dart';
import 'package:robin_book/domain/use_cases/work/get_author_use_case.dart';
import 'package:robin_book/domain/use_cases/work/get_work_editions_use_case.dart';
import 'package:robin_book/domain/use_cases/work/get_work_use_case.dart';
import 'package:robin_book/domain/use_cases/work/search_works_by_title_or_author_use_case.dart';
import 'package:robin_book/ui/route_manager.dart';
import 'package:robin_book/ui/screens/book_search/book_search_screen.dart';
import 'package:robin_book/ui/state_management/favorite_work_provider.dart';
import 'package:robin_book/ui/state_management/work_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<WorkProvider>(
          create: (BuildContext context) => WorkProvider(
              getAuthorUseCase: GetAuthorUseCase(
                  workRepository: WorkRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              ),
              getWorkEditionsUseCase: GetWorkEditionsUseCase(
                  workRepository: WorkRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              ),
              getWorkUseCase: GetWorkUseCase(
                  workRepository: WorkRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              ),
              searchWorksByTitleOrAuthorUseCase: SearchWorksByTitleOrAuthorUseCase(
                  workRepository: WorkRepository(
                      remoteDataSource: RemoteDataSource(),
                      workDatabase: WorkDatabase()
                  )
              )
          ),
        ),
        ListenableProvider<FavoriteWorkProvider>(
          create: (BuildContext context) => FavoriteWorkProvider(
              addFavoriteWorkUseCase: AddFavoriteWorkUseCase(
                  favoriteWorkRepository: FavoriteWorkRepository(
                      workDatabase: WorkDatabase()
                  )
              ),
              deleteFavoriteWorkUseCase: DeleteFavoriteWorkUseCase(
                  favoriteWorkRepository: FavoriteWorkRepository(
                      workDatabase: WorkDatabase()
                  )
              ),
              getFavoriteWorkUseCase: GetFavoriteWorkUseCase(
                  favoriteWorkRepository: FavoriteWorkRepository(
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
