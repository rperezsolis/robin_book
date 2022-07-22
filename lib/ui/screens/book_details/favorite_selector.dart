import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/data/data_source/local/work_database.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/ui/state_management/favorite_work_provider.dart';

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
  late FavoriteWorkProvider favoriteWorkProvider;

  @override
  void initState() {
    super.initState();
    favoriteWorkProvider = Provider.of<FavoriteWorkProvider>(context, listen: false);
    favoriteWorkProvider.getFavoriteWork(key: widget.work.key);
    favoriteWorkProvider.addListener(_observeSnackBarMessage);
  }

  @override
  void dispose() {
    super.dispose();
    favoriteWorkProvider.removeListener(_observeSnackBarMessage);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          favoriteWorkProvider.addOrDeleteFavoriteWork(work: widget.work);
        },
        icon: Selector<FavoriteWorkProvider, FavoriteWork?>(
          builder: (BuildContext context, FavoriteWork? favoriteWork, Widget? child) {
            return favoriteWork != null
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border);
            },
          selector: (_, favoriteWorkProvider) => favoriteWorkProvider.currentFavoriteWork,
        ),
    );
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
