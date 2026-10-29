// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => _PlaceModel(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String?,
  categoryName: json['categoryName'] as String?,
  shortDescription: json['shortDescription'] as String?,
  description: json['description'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  openingHours: json['openingHours'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  thumbnailUrl: json['thumbnailUrl'] as String?,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  districtId: json['districtId'] as String?,
  districtName: json['districtName'] as String?,
  isFeatured: json['isFeatured'] as bool? ?? false,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$PlaceModelToJson(_PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'categoryName': instance.categoryName,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'address': instance.address,
      'phone': instance.phone,
      'openingHours': instance.openingHours,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'thumbnailUrl': instance.thumbnailUrl,
      'imageUrls': instance.imageUrls,
      'districtId': instance.districtId,
      'districtName': instance.districtName,
      'isFeatured': instance.isFeatured,
      'updatedAt': instance.updatedAt,
    };
