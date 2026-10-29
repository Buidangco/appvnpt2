class Category {
  const Category({
    required this.id,
    required this.name,
    required this.type,
    this.iconName,
  });

  final String id;
  final String name;
  final String type;
  final String? iconName;
}
