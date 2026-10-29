import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/news_item.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
abstract class NewsModel with _$NewsModel {
  const factory NewsModel({
    required String id,
    required String title,
    String? summary,
    String? content,
    String? contentType,
    String? thumbnailUrl,
    @Default(<String>[]) List<String> imageUrls,
    String? categoryName,
    String? publishedAt,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}

extension NewsModelMapper on NewsModel {
  NewsItem toEntity() {
    return NewsItem(
      id: id,
      title: title,
      summary: summary,
      content: content,
      contentType: contentType,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      categoryName: categoryName,
      publishedAt: publishedAt,
    );
  }
}
