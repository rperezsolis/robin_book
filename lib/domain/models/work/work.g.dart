// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Work _$WorkFromJson(Map<String, dynamic> json) => Work(
      key: json['key'] as String,
      title: json['title'] as String,
      coverIds:
          (json['covers'] as List<dynamic>?)?.map((e) => e as int).toList(),
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => WorkAuthor.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WorkToJson(Work instance) => <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'covers': instance.coverIds,
      'authors': instance.authors?.map((e) => e.toJson()).toList(),
      'subjects': instance.subjects,
    };
