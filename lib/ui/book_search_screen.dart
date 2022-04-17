import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:robin_book/domain/work_search/work_search.dart';
import 'package:robin_book/ui/book_item.dart';
import 'package:robin_book/ui/book_search_bar.dart';

class BookSearchScreen extends StatelessWidget {
  //TODO: Get workSearch value from the data layer
  final WorkSearch mockedWorkSearch = WorkSearch.fromJson(jsonDecode('''{
    "numFound": 109,
    "start": 0,
    "numFoundExact": true,
    "docs": [
        {
            "key": "/works/OL10278W",
            "title": "El Principito",
            "cover_i": 4978949
        },
        {
            "key": "/works/OL24210967W",
            "title": "El Principito",
            "cover_i": 10660443
        },
        {
            "key": "/works/OL15723255W",
            "title": "El Principito",
            "cover_i": 7275560
        },
        {
            "key": "/works/OL24150941W",
            "title": "el principito",
            "cover_i": 10549941
        },
        {
            "key": "/works/OL15166387W",
            "title": "El principito",
            "cover_i": 6389929
        },
        {
            "key": "/works/OL17787585W",
            "title": "El principito",
            "cover_i": 8067157
        },
        {
            "key": "/works/OL17808434W",
            "title": "El principito",
            "cover_i": 8095078
        },
        {
            "key": "/works/OL17902597W",
            "title": "El principito",
            "cover_i": 8217848
        },
        {
            "key": "/works/OL20119027W",
            "title": "El Principito",
            "cover_i": 8775023
        },
        {
            "key": "/works/OL19793202W",
            "title": "El principito"
        },
        {
            "key": "/works/OL20851391W",
            "title": "El Principito",
            "cover_i": 10163236
        },
        {
            "key": "/works/OL20819370W",
            "title": "El principito",
            "cover_i": 10121498
        },
        {
            "key": "/works/OL20856572W",
            "title": "El Principito",
            "cover_i": 10170389
        },
        {
            "key": "/works/OL20003491W",
            "title": "El principito"
        },
        {
            "key": "/works/OL19863207W",
            "title": "El principito "
        },
        {
            "key": "/works/OL19863208W",
            "title": "El principito",
            "cover_i": 8668942
        },
        {
            "key": "/works/OL13204076M",
            "title": "Principito, El"
        },
        {
            "key": "/works/OL13262031M",
            "title": "El Principito"
        },
        {
            "key": "/works/OL12953586M",
            "title": "El Principito"
        },
        {
            "key": "/works/OL12953832M",
            "title": "El Principito",
            "cover_i": 3344602
        }
    ],
    "num_found": 109,
    "q": "el principito",
    "offset": 0
}'''));

  BookSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookSearchBar(
          inputCallback: () {
            //TODO: Search actual results from the api and update the ui accordingly.
            debugPrint('Calling callback');
          },
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75
              ),
              itemCount: mockedWorkSearch.items.length,
              itemBuilder: (BuildContext context, int index) {
                return BookItem(
                    workSearchItem: mockedWorkSearch.items[index]
                );
              }
          )
        )
      ],
    );
  }
}
