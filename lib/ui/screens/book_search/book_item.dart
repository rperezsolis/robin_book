import 'package:flutter/material.dart';
import 'package:robin_book/domain/enums/picture_size.dart';
import 'package:robin_book/domain/work_search/work_search_item.dart';

class BookItem extends StatelessWidget {
  final WorkSearchItem workSearchItem;

  const BookItem({
    Key? key,
    required this.workSearchItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FadeInImage.assetNetwork(
                  //TODO: Move urls to data layer when available.
                  image: 'https://covers.openlibrary.org/b/id/${workSearchItem.coverId}-'
                      '${PictureSize.medium.urlValue}.jpg',
                  placeholder: 'assets/images/image_placeholder.png',
                  imageErrorBuilder: (BuildContext context, Object error, StackTrace? stacktrace) {
                    return Image.asset('assets/images/image_placeholder.png');
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  workSearchItem.title
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
