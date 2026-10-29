// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => _NewsModel(
  id: json['id'] as String,
  title: json['title'] as String,
  summary: json['summary'] as String?,
  content: json['content'] as String?,
  contentType: json['contentType'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  categoryName: json['categoryName'] as String?,
  publishedAt: json['publishedAt'] as String?,
);

Map<String, dynamic> _$NewsModelToJson(_NewsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'contentType': instance.contentType,
      'thumbnailUrl': instance.thumbnailUrl,
      'imageUrls': instance.imageUrls,
      'categoryName': instance.categoryName,
      'publishedAt': instance.publishedAt,
    };
