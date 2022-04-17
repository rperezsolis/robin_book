import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:robin_book/domain/author/author.dart';
import 'package:robin_book/domain/edition/work_editions.dart';
import 'package:robin_book/domain/enums/picture_size.dart';
import 'package:robin_book/domain/work/work.dart';
import 'package:robin_book/ui/screens/book_details/edition_item.dart';

class BookDetailsScreen extends StatelessWidget {
  static const routeName = 'BookDetailsScreen';
  //TODO: Get work, authors, and workEditions value from the data layer
  final work = Work.fromJson(jsonDecode('''{
    "created": {
        "type": "/type/datetime",
        "value": "2009-10-05T18:44:42.752306"
    },
    "subjects": [
        "Fantasy",
        "Juvenile fiction",
        "Alegorías",
        "Cuentos de hadas",
        "Princes",
        "Readers",
        "Spanish language",
        "Fairy tales",
        "Friendship"
    ],
    "latest_revision": 10,
    "key": "/works/OL10278W",
    "title": "El Principito",
    "authors": [
        {
            "type": {
                "key": "/type/author_role"
            },
            "author": {
                "key": "/authors/OL31901A"
            }
        }
    ],
    "type": {
        "key": "/type/work"
    },
    "last_modified": {
        "type": "/type/datetime",
        "value": "2020-02-14T06:02:22.644946"
    },
    "covers": [
        4978949,
        996201
    ],
    "revision": 10
}'''));
  final author = Author.fromJson(jsonDecode(r'''{
    "wikipedia": "http://fr.wikipedia.org/wiki/Antoine_de_Saint-Exupéry",
    "key": "/authors/OL31901A",
    "type": {
        "key": "/type/author"
    },
    "name": "Antoine de Saint-Exupéry",
    "bio": "Antoine de Saint-Exupéry (29 June 1900—31 July 1944) was a French writer and aviator. He is best remembered for his novella *The Little Prince (Le Petit Prince)*, and for his books about aviation adventures, including Night Flight and Wind, Sand and Stars.\r\n\r\nHe was a successful commercial pilot before World War II, joining the Armée de l'Air (French Air Force) on the outbreak of war, flying reconnaissance missions until the armistice with Germany. Following a spell of writing in the United States, he joined the Free French Forces. He disappeared on a reconnaissance flight over the Mediterranean in July 1944.\r\n\r\n([Source][1])\r\n\r\n\r\n  [1]: http://en.wikipedia.org/wiki/Antoine_de_Saint-Exupéry",
    "photos": [
        6338378
    ],
    "death_date": "31 July 1944",
    "photograph": "/static/images/book.trans.gif",
    "personal_name": "Antoine de Saint-Exupéry",
    "remote_ids": {
        "viaf": "93810507",
        "wikidata": "Q2908",
        "isni": "0000000120966599"
    },
    "birth_date": "29 June 1900",
    "alternate_names": [
        "A de Saint-Exupery",
        "A. de Saint-Exupery",
        "A. Saint-Exupery",
        "Antione de Saint-Exupery",
        "Anto Saint Exupery",
        "Antoine de Saint Exupéry",
        "Antoine de Saint-Exupery",
        "Antoine de Saint-Exupery",
        "Antoine de Saint-exupéry",
        "Antoine de St-Exupery",
        "Antoine Exupery",
        "Antoine Jean-Baptiste Marie Roger de Saint Exupéry",
        "Antoine Saint-Exupéry"
    ],
    "latest_revision": 23,
    "revision": 23,
    "created": {
        "type": "/type/datetime",
        "value": "2008-04-01T03:28:50.625462"
    },
    "last_modified": {
        "type": "/type/datetime",
        "value": "2021-03-16T18:33:51.978431"
    }
}'''));
  final workEditions = WorkEditions.fromJson(jsonDecode('''{
    "links": {
        "self": "/works/OL10278W/editions.json?limit=20&offset=0",
        "work": "/works/OL10278W"
    },
    "size": 4,
    "entries": [
        {
            "publishers": [
                "Salamandra"
            ],
            "physical_format": "CD-ROM",
            "last_modified": {
                "type": "/type/datetime",
                "value": "2011-05-04T05:17:42.844605"
            },
            "source_records": [
                "amazon:8441506213:2-au:3177397150:219949"
            ],
            "title": "El Principito",
            "identifiers": {
                "goodreads": [
                    "4162610"
                ]
            },
            "isbn_13": [
                "9788441506213"
            ],
            "created": {
                "type": "/type/datetime",
                "value": "2008-04-30T09:38:13.731961"
            },
            "languages": [
                {
                    "key": "/languages/spa"
                }
            ],
            "isbn_10": [
                "8441506213"
            ],
            "publish_date": "January 1, 1999",
            "key": "/books/OL9803842M",
            "authors": [
                {
                    "key": "/authors/OL31901A"
                }
            ],
            "latest_revision": 6,
            "works": [
                {
                    "key": "/works/OL10278W"
                }
            ],
            "type": {
                "key": "/type/edition"
            },
            "revision": 6
        },
        {
            "publishers": [
                "Editorial Lectorum"
            ],
            "number_of_pages": 85,
            "weight": "4.2 ounces",
            "covers": [
                2295636
            ],
            "physical_format": "Paperback",
            "key": "/books/OL9175804M",
            "authors": [
                {
                    "key": "/authors/OL31901A"
                }
            ],
            "subjects": [
                "Literature - Classics / Criticism",
                "Education",
                "Spanish: Adult Nonfiction",
                "Classics",
                "Children's Books / 9-12 Years",
                "General"
            ],
            "edition_name": "Primera edicion. Decimoseg. reimpresion edition",
            "languages": [
                {
                    "key": "/languages/spa"
                }
            ],
            "first_sentence": "CUANDO YO TENIA seis anos vi una vez una lamina magnificia en un libro sobre el bosque virgen que se llamaba &lt;&lt;Historias Vividas>>.",
            "source_records": [
                "amazon:9687748044:im:2806354308:252049"
            ],
            "title": "El Principito",
            "identifiers": {
                "librarything": [
                    "11883"
                ],
                "goodreads": [
                    "1974521"
                ]
            },
            "publish_date": "July 15, 2006",
            "works": [
                {
                    "key": "/works/OL10278W"
                }
            ],
            "type": {
                "key": "/type/edition"
            },
            "physical_dimensions": "8 x 5.4 x 0.4 inches",
            "isbn_10": [
                "9687748044"
            ],
            "isbn_13": [
                "9789687748047"
            ],
            "classifications": {},
            "translation_of": "Le Petit Prince",
            "translated_from": [
                {
                    "key": "/languages/fre"
                }
            ],
            "latest_revision": 10,
            "revision": 10,
            "created": {
                "type": "/type/datetime",
                "value": "2008-04-30T09:38:13.731961"
            },
            "last_modified": {
                "type": "/type/datetime",
                "value": "2021-03-16T20:02:15.447630"
            }
        },
        {
            "publishers": [
                "Yoyo Music USA Inc"
            ],
            "weight": "5.6 ounces",
            "covers": [
                1052516
            ],
            "physical_format": "Audio CD",
            "last_modified": {
                "type": "/type/datetime",
                "value": "2011-05-04T05:17:42.844605"
            },
            "latest_revision": 9,
            "key": "/books/OL9151491M",
            "authors": [
                {
                    "key": "/authors/OL31901A"
                }
            ],
            "contributions": [
                "Santiago Munevar (Narrator)"
            ],
            "subjects": [
                "Spanish: Adult Fiction",
                "Literary Collections",
                "Continental European",
                "Literature & Fiction"
            ],
            "edition_name": "Unabridged edition",
            "languages": [
                {
                    "key": "/languages/spa"
                }
            ],
            "source_records": [
                "amazon:9589494722:ij:2516915015:226540"
            ],
            "title": "El Principito [ABRIDGED]",
            "identifiers": {
                "librarything": [
                    "11883"
                ],
                "goodreads": [
                    "67782"
                ]
            },
            "created": {
                "type": "/type/datetime",
                "value": "2008-04-30T09:38:13.731961"
            },
            "isbn_13": [
                "9789589494721"
            ],
            "isbn_10": [
                "9589494722"
            ],
            "publish_date": "February 1, 2001",
            "works": [
                {
                    "key": "/works/OL10278W"
                }
            ],
            "type": {
                "key": "/type/edition"
            },
            "physical_dimensions": "5.8 x 5 x 0.9 inches",
            "revision": 9
        },
        {
            "publishers": [
                "Salamandra"
            ],
            "covers": [
                8041638
            ],
            "physical_format": "Paperback",
            "key": "/books/OL9142262M",
            "authors": [
                {
                    "key": "/authors/OL31901A"
                }
            ],
            "subjects": [
                "General",
                "Children's 12-Up - Fiction - General",
                "Juvenile Fiction"
            ],
            "source_records": [
                "amazon:8478880062:ht:1962642520:239632"
            ],
            "title": "El Principito",
            "identifiers": {
                "goodreads": [
                    "6820160"
                ],
                "librarything": [
                    "11883"
                ]
            },
            "languages": [
                {
                    "key": "/languages/spa"
                }
            ],
            "publish_date": "May 1990",
            "works": [
                {
                    "key": "/works/OL10278W"
                }
            ],
            "type": {
                "key": "/type/edition"
            },
            "first_sentence": "CUANDO YO TENIA seis anos vi una vez una lamina magnificia en un libro sobre el bosque virgen que se llamaba &lt;&lt;Historias Vividas>>.",
            "isbn_10": [
                "8478880062"
            ],
            "isbn_13": [
                "9788478880065"
            ],
            "classifications": {},
            "physical_dimensions": "22 x 15 x  centimeters",
            "number_of_pages": 95,
            "translated_from": [
                {
                    "key": "/languages/fre"
                }
            ],
            "contributors": [
                {
                    "name": "Bonifacio del Carril",
                    "role": "Translator"
                }
            ],
            "translation_of": "Le Petit Prince",
            "latest_revision": 10,
            "revision": 10,
            "created": {
                "type": "/type/datetime",
                "value": "2008-04-30T09:38:13.731961"
            },
            "last_modified": {
                "type": "/type/datetime",
                "value": "2022-01-02T00:25:23.552159"
            }
        }
    ]
}'''));

  BookDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(work.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Title: '
                  ),
                  Text(
                      work.title
                  )
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  const Text(
                    'Authors: '
                  ),
                  Text(
                    author.name
                  )
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
                      work.subjects?.join(', ') ?? '',
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
              const Text(
                'Editions: '
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: workEditions.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 225,
                      child: EditionItem(
                          edition: workEditions.items[index]
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
