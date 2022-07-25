// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Edition _$EditionFromJson(Map<String, dynamic> json) => Edition(
      title: json['title'] as String,
      publishDate: json['publish_date'] as String?,
      publishers: (json['publishers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      coverIds:
          (json['covers'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$EditionToJson(Edition instance) => <String, dynamic>{
      'title': instance.title,
      'publish_date': instance.publishDate,
      'publishers': instance.publishers,
      'covers': instance.coverIds,
    };
