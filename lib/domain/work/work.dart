import 'package:json_annotation/json_annotation.dart';
import 'package:robin_book/domain/work/work_author.dart';

part 'work.g.dart';

@JsonSerializable(explicitToJson: true)
class Work {
  String key;
  String title;
  @JsonKey(name: 'covers')
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

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);

  Map<String, dynamic> toJson() => _$WorkToJson(this);
}