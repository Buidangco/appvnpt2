// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContactModel _$ContactModelFromJson(Map<String, dynamic> json) =>
    _ContactModel(
      id: json['id'] as String,
      name: json['name'] as String,
      digitalExport: json['digitalExport'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      logoUrl: json['logoUrl'] as String?,
      website: json['website'] as String?,
      email: json['email'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ContactModelToJson(_ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'digitalExport': instance.digitalExport,
      'address': instance.address,
      'phone': instance.phone,
      'logoUrl': instance.logoUrl,
      'website': instance.website,
      'email': instance.email,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
