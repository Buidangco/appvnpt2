class Place {
  const Place({
    required this.id,
    required this.name,
    this.type,
    this.categoryName,
    this.shortDescription,
    this.description,
    this.address,
    this.phone,
    this.openingHours,
    this.latitude,
    this.longitude,
    this.thumbnailUrl,
    this.imageUrls = const <String>[],
    this.districtId,
    this.districtName,
    this.isFeatured = false,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String? type;
  final String? categoryName;
  final String? shortDescription;
  final String? description;
  final String? address;
  final String? phone;
  final String? openingHours;
  final double? latitude;
  final double? longitude;
  final String? thumbnailUrl;
  final List<String> imageUrls;
  final String? districtId;
  final String? districtName;
  final bool isFeatured;
  final String? updatedAt;
}
