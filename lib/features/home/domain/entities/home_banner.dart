class HomeBanner {
  const HomeBanner({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.linkType,
    this.linkId,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String? linkType;
  final String? linkId;
}
