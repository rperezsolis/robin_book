import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/data/data_source/work_database.dart';
import 'package:robin_book/domain/work/work.dart';
import 'package:robin_book/ui/screens/book_search/book_item.dart';
import 'package:robin_book/domain/work_search/work_search_item.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = 'FavoritesScreen';

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late WorkDatabase workDatabase;

  @override
  void initState() {
    super.initState();
    workDatabase = Provider.of<WorkDatabase>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Books'),
      ),
      body: SizedBox.expand(
        child: StreamBuilder(
            stream: workDatabase.watchAllFavoriteWorks,
            builder: (BuildContext context, AsyncSnapshot<List<FavoriteWork>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<FavoriteWork> favoriteWorks = snapshot.data!.where(
                        (favoriteWork) => favoriteWork.work != null).toList();
                return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75
                    ),
                    itemCount: favoriteWorks.length,
                    itemBuilder: (BuildContext context, int index) {
                      Work work = favoriteWorks[index].work!;
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Center(
                            child: BookItem(
                              workSearchItem: WorkSearchItem(
                                  key: work.key,
                                  title: work.title,
                                  coverId: work.coverIds?.first
                              )
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              int? deletedItems = await workDatabase
                                  .deleteFavoriteBook(key: work.key);
                              if (deletedItems != null) {
                                const snackBar = SnackBar(
                                  content: Text('Book deleted from favorites'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            }, 
                            icon: const Padding(
                              padding: EdgeInsets.only(top: 16, right: 16),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.deepPurple,
                              ),
                            )
                          )
                        ],
                      );
                    }
                );
              }
            }
        ),
      ),
    );
  }
}
