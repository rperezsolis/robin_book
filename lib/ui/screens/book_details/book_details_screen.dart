import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/enums/picture_size.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/ui/screens/book_details/edition_item.dart';
import 'package:robin_book/ui/screens/book_details/favorite_selector.dart';
import 'package:robin_book/ui/state_management/work_provider.dart';

/// Represents the Book Details screen.
class BookDetailsScreen extends StatefulWidget {
  static const routeName = 'BookDetailsScreen';
  final Work work;

  const BookDetailsScreen({
    Key? key,
    required this.work
  }) : super(key: key);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late WorkProvider workProvider;
  late ScrollController editionsScrollController;

  @override
  void initState() {
    super.initState();
    workProvider = Provider.of<WorkProvider>(context, listen: false);
    editionsScrollController = ScrollController()..addListener(() {
      double maxScroll = editionsScrollController.position.maxScrollExtent;
      double currentScroll = editionsScrollController.position.pixels;
      if (maxScroll == currentScroll) {
        if (workProvider.currentWork != null) {
          workProvider.getWorkEditions(
              key: workProvider.currentWork!.key,
              isFirstPage: false
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    editionsScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Details'),
          actions: [
            FavoriteSelector(
              work: widget.work
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<WorkProvider, Work?>(
                    builder: (BuildContext context, Work? work, Widget? child) {
                      if (work != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Title: '
                                ),
                                Expanded(
                                  child: Text(
                                      work.title
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Authors: '
                                ),
                                Selector<WorkProvider, List<Author>?>(
                                  builder: (BuildContext context, List<Author>? authors,
                                      Widget? child) {
                                    if (authors != null && authors.isNotEmpty) {
                                      String text = authors.map((author) => author.name)
                                          .toList().join(', ');
                                      return Expanded(
                                        child: Text(
                                          text
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        '---'
                                      );
                                    }
                                  },
                                  selector: (_, workProvider) => workProvider.currentAuthors,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Subjects: '
                                ),
                                Expanded(
                                    child: Text(
                                      work.subjects?.join(', ') ?? '---',
                                    )
                                )
                              ],
                            ),
                            const SizedBox(height: 8,),
                            const Text(
                                'Covers: '
                            ),
                            SizedBox(
                              height: 300,
                              child: PageView(
                                  controller: PageController(
                                      initialPage: 0
                                  ),
                                  children: work.coverIds?.map((coverId) => FadeInImage
                                      .assetNetwork(
                                    //TODO: Move urls to data layer when available.
                                    image: 'https://covers.openlibrary.org/b/id/$coverId-'
                                        '${PictureSize.large.urlValue}.jpg',
                                    placeholder: 'assets/images/image_placeholder.png',
                                    imageErrorBuilder: (BuildContext context, Object error,
                                        StackTrace? stacktrace) {
                                      return Image.asset('assets/images/image_placeholder.png');
                                    },
                                  )).toList() ?? [Image.asset('assets/images/image_placeholder.png')]
                              ),
                            ),
                            const SizedBox(height: 8,),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    selector: (_, workProvider) => workProvider.currentWork
                ),
                const Text(
                    'Editions: '
                ),
                SizedBox(
                  height: 300,
                  child: Selector<WorkProvider, WorkEditions?>(
                    builder: (BuildContext context, WorkEditions? workEditions, Widget? child) {
                      if (workEditions != null) {
                        return ListView.builder(
                          itemCount: workEditions.items.length,
                          controller: editionsScrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 225,
                              child: EditionItem(
                                  edition: workEditions.items[index]
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    selector: (_, workProvider) => workProvider.currentWorkEditions,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        workProvider.resetWorkEditions();
        return true;
      }
    );
  }
}
