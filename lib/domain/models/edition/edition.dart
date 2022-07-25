import 'package:json_annotation/json_annotation.dart';

part 'edition.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Edition {
  String title;
  String? publishDate;
  List<String>? publishers;
  @JsonKey(name: 'covers')
  List<int>? coverIds;

  Edition({
    required this.title,
    this.publishDate,
    this.publishers,
    this.coverIds
  });

  factory Edition.fromJson(Map<String, dynamic> json) => _$EditionFromJson(json);

  Map<String, dynamic> toJson() => _$EditionToJson(this);
}