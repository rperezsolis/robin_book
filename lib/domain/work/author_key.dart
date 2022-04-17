import 'package:json_annotation/json_annotation.dart';

part 'author_key.g.dart';

@JsonSerializable()
class AuthorKey {
  String key;

  AuthorKey({
    required this.key
  });

  factory AuthorKey.fromJson(Map<String, dynamic> json) => _$AuthorKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorKeyToJson(this);
}