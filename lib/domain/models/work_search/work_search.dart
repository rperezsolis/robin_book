import 'package:json_annotation/json_annotation.dart';
import 'package:robin_book/domain/models/work_search/work_search_item.dart';

part 'work_search.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkSearch {
  @JsonKey(name: 'docs')
  List<WorkSearchItem> items;

  WorkSearch({
    required this.items
  });

  factory WorkSearch.fromJson(Map<String, dynamic> json) => _$WorkSearchFromJson(json);

  Map<String, dynamic> toJson() => _$WorkSearchToJson(this);
}