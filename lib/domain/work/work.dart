import 'package:robin_book/domain/work/work_author.dart';

class Work {
  String key;
  String title;
  List<int>? coverIds;
  List<WorkAuthor>? authors;
  List<String>? subjects;

  Work({
    required this.key,
    required this.title,
    this.coverIds,
    this.authors,
    this.subjects
  });
}