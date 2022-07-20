import 'package:json_annotation/json_annotation.dart';

part 'work_search_item.g.dart';

@JsonSerializable()
class WorkSearchItem {
  String key;
  String title;
  @JsonKey(name: 'cover_i')
  int? coverId;

  WorkSearchItem({
    required this.key,
    required this.title,
    this.coverId
  });

  factory WorkSearchItem.fromJson(Map<String, dynamic> json) => _$WorkSearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$WorkSearchItemToJson(this);
}