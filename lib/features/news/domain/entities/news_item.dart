class NewsItem {
  const NewsItem({
    required this.id,
    required this.title,
    this.summary,
    this.content,
    this.contentType,
    this.thumbnailUrl,
    this.imageUrls = const <String>[],
    this.categoryName,
    this.publishedAt,
  });

  final String id;
  final String title;
  final String? summary;
  final String? content;
  final String? contentType;
  final String? thumbnailUrl;
  final List<String> imageUrls;
  final String? categoryName;
  final String? publishedAt;
}
