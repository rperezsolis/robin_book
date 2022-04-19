import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/ui/screens/book_details/book_details_screen.dart';
import 'package:robin_book/ui/screens/book_search/book_item.dart';
import 'package:robin_book/ui/screens/book_search/book_search_bar.dart';
import 'package:robin_book/ui/screens/favorites/favorites_screen.dart';
import 'package:robin_book/ui/state_management/book_provider.dart';

class BookSearchScreen extends StatefulWidget {
  static const routeName = 'BookSearchScreen';

  const BookSearchScreen({Key? key}) : super(key: key);

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  late BookProvider bookProvider;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    scrollController = ScrollController()..addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if (maxScroll == currentScroll) {
        bookProvider.searchWorksByTitleOrAuthor(keyword: bookProvider.lastKeyword,
            isFirstPage: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('Robin Book'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                Navigator.pushNamed(
                  context,
                  FavoritesScreen.routeName
                );
              },
              itemBuilder: (BuildContext context) {
                return {'Go to Favorites'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            BookSearchBar(
              inputCallback: (String keyword) {
                bookProvider.searchWorksByTitleOrAuthor(keyword: keyword,
                    isFirstPage: true);
              },
            ),
            Consumer<BookProvider>(builder: (BuildContext context,
                BookProvider bookProvider, Widget? child) {
              if (bookProvider.isLoadingFirstPage) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (bookProvider.workSearch != null &&
                  bookProvider.workSearch!.items.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75
                      ),
                      itemCount: bookProvider.workSearch!.items.length,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: BookItem(
                              workSearchItem: bookProvider.workSearch!.items[index]
                          ),
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            late BuildContext dialogContext;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                dialogContext = context;
                                return const SimpleDialog(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  ],
                                );
                              }
                            );
                            await bookProvider.getWork(
                                key: bookProvider.workSearch!.items[index].key
                            );
                            bookProvider.getWorkEditions(
                                key: bookProvider.workSearch!.items[index].key,
                                isFirstPage: true
                            );
                            Navigator.of(dialogContext).pop();
                            if (bookProvider.currentWork != null) {
                              Navigator.pushNamed(
                                  context,
                                  BookDetailsScreen.routeName,
                                  arguments: bookProvider.currentWork
                              );
                            }
                          },
                        );
                      }
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      child: SvgPicture.asset('assets/images/image_reading.svg')
                    ),
                  )
                );
              }
            }),
          ],
        ),
      );
  }
}
