import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/data/data_source/work_database.dart';
import 'package:robin_book/domain/work/work.dart';

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
    workDatabase = Provider.of<WorkDatabase>(context, listen: false);
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
            await workDatabase.addFavoriteBook(work: widget.work);
          } else {
            await workDatabase.deleteFavoriteBook(key: widget.work.key);
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
