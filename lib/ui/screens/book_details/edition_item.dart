import 'package:flutter/material.dart';
import 'package:robin_book/domain/models/edition/edition.dart';
import 'package:robin_book/domain/models/enums/picture_size.dart';

class EditionItem extends StatelessWidget {
  final Edition edition;

  const EditionItem({
    Key? key,
    required this.edition
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
                    image: 'https://covers.openlibrary.org/b/id/${edition.coverIds?.first}-'
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
                  edition.title,
                  textAlign: TextAlign.center,
                ),
              ),
              if (edition.publishDate != null)
                Text(
                  edition.publishDate!
                ),
            ],
          ),
        ),
      ),
    );
  }
}
