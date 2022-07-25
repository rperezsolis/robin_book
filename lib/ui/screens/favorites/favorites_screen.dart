import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/ui/screens/book_search/book_item.dart';
import 'package:robin_book/domain/models/work_search/work_search_item.dart';
import 'package:robin_book/ui/state_management/favorite_work_provider.dart';

/// Represents the Favorite Books screen.
class FavoritesScreen extends StatefulWidget {
  static const routeName = 'FavoritesScreen';

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoriteWorkProvider favoriteWorkProvider;

  @override
  void initState() {
    super.initState();
    favoriteWorkProvider = Provider.of<FavoriteWorkProvider>(context, listen: false);
    favoriteWorkProvider.addListener(_observeSnackBarMessage);
    _loadFavoriteWorks();
  }

  @override
  void dispose() {
    super.dispose();
    favoriteWorkProvider.removeListener(_observeSnackBarMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Books'),
      ),
      body: SizedBox.expand(
        child:  Consumer<FavoriteWorkProvider>(builder: (BuildContext context,
            FavoriteWorkProvider favoriteWorkProvider, Widget? child) {
          if (favoriteWorkProvider.favoriteWorks.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'You have not added any book to your favorite list yet',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75
                ),
                itemCount: favoriteWorkProvider.favoriteWorks.length,
                itemBuilder: (BuildContext context, int index) {
                  Work work = favoriteWorkProvider.favoriteWorks[index].work!;
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
                            await favoriteWorkProvider.deleteFavoriteWork(key: work.key);
                            await _loadFavoriteWorks();
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
        })
      ),
    );
  }

  Future<void> _loadFavoriteWorks() async {
    await favoriteWorkProvider.getAllFavoriteWorks();
  }

  void _observeSnackBarMessage() {
    if (mounted && favoriteWorkProvider.snackBarMessage != null &&
        favoriteWorkProvider.snackBarMessage!.isNotEmpty) {
      String message = favoriteWorkProvider.snackBarMessage!;
      favoriteWorkProvider.resetSnackBarMessage();
      _showSnackBar(message);
    }
  }

  void _showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
