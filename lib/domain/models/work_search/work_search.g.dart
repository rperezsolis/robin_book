// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSearch _$WorkSearchFromJson(Map<String, dynamic> json) => WorkSearch(
      items: (json['docs'] as List<dynamic>)
          .map((e) => WorkSearchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkSearchToJson(WorkSearch instance) =>
    <String, dynamic>{
      'docs': instance.items.map((e) => e.toJson()).toList(),
    };
