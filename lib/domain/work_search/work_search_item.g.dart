// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSearchItem _$WorkSearchItemFromJson(Map<String, dynamic> json) =>
    WorkSearchItem(
      key: json['key'] as String,
      title: json['title'] as String,
      coverId: json['cover_i'] as int?,
    );

Map<String, dynamic> _$WorkSearchItemToJson(WorkSearchItem instance) =>
    <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'cover_i': instance.coverId,
    };
