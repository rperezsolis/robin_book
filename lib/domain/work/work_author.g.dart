// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkAuthor _$WorkAuthorFromJson(Map<String, dynamic> json) => WorkAuthor(
      authorKey: AuthorKey.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkAuthorToJson(WorkAuthor instance) =>
    <String, dynamic>{
      'author': instance.authorKey.toJson(),
    };
