// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_editions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkEditions _$WorkEditionsFromJson(Map<String, dynamic> json) => WorkEditions(
      items: (json['entries'] as List<dynamic>)
          .map((e) => Edition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkEditionsToJson(WorkEditions instance) =>
    <String, dynamic>{
      'entries': instance.items.map((e) => e.toJson()).toList(),
    };
