import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  String key;
  String name;
  @JsonKey(name: 'wikipedia')
  String? wikipediaUrl;
  String? bio;
  @JsonKey(name: 'photos')
  List<int>? photoIds;

  Author({
    required this.key,
    required this.name,
    this.wikipediaUrl,
    this.bio,
    this.photoIds
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}