// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      key: json['key'] as String,
      name: json['name'] as String,
      wikipediaUrl: json['wikipedia'] as String?,
      bio: json['bio'] as String?,
      photoIds:
          (json['photos'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'wikipedia': instance.wikipediaUrl,
      'bio': instance.bio,
      'photos': instance.photoIds,
    };
