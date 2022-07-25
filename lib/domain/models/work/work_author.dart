import 'package:json_annotation/json_annotation.dart';
import 'package:robin_book/domain/models/work/author_key.dart';

part 'work_author.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkAuthor {
  @JsonKey(name: 'author')
  AuthorKey authorKey;

  WorkAuthor({
    required this.authorKey
  });

  factory WorkAuthor.fromJson(Map<String, dynamic> json) => _$WorkAuthorFromJson(json);

  Map<String, dynamic> toJson() => _$WorkAuthorToJson(this);
}