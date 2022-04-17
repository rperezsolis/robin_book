import 'package:json_annotation/json_annotation.dart';
import 'package:robin_book/domain/edition/edition.dart';

part 'work_editions.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkEditions {
  @JsonKey(name: 'entries')
  List<Edition> items;

  WorkEditions({
    required this.items
  });

  factory WorkEditions.fromJson(Map<String, dynamic> json) => _$WorkEditionsFromJson(json);

  Map<String, dynamic> toJson() => _$WorkEditionsToJson(this);
}