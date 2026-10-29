class Contact {
  const Contact({
    required this.id,
    required this.name,
    this.digitalExport,
    this.address,
    this.phone,
    this.logoUrl,
    this.website,
    this.email,
    this.latitude,
    this.longitude,
  });

  final String id;
  final String name;
  final String? digitalExport;
  final String? address;
  final String? phone;
  final String? logoUrl;
  final String? website;
  final String? email;
  final double? latitude;
  final double? longitude;
}
