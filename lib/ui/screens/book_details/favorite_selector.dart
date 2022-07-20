import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';

class FavoriteSelector extends StatefulWidget {
  final Work work;

  const FavoriteSelector({
    Key? key,
    required this.work
  }) : super(key: key);

  @override
  State<FavoriteSelector> createState() => _FavoriteSelectorState();
}

class _FavoriteSelectorState extends State<FavoriteSelector> {
  late WorkDatabase workDatabase;
  FavoriteWork? favoriteWork;

  @override
  void initState() {
    super.initState();
    workDatabase = WorkDatabase();
    workDatabase.getFavoriteBook(key: widget.work.key)
        .then((value) {
          setState(() {
            favoriteWork = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          favoriteWork = await workDatabase
              .getFavoriteBook(key: widget.work.key);
          if (favoriteWork == null) {
            int? id = await workDatabase.addFavoriteBook(work: widget.work);
            if (id != null) {
              const snackBar = SnackBar(
                content: Text('Book added to favorites'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            int? deletedItems = await workDatabase
                .deleteFavoriteBook(key: widget.work.key);
            if (deletedItems != null) {
              const snackBar = SnackBar(
                content: Text('Book deleted from favorites'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
          FavoriteWork? favoriteWorkFromDB = await workDatabase
              .getFavoriteBook(key: widget.work.key);
          setState(() {
            favoriteWork = favoriteWorkFromDB;
          });
        },
        icon: favoriteWork != null
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border)
    );
  }
}
