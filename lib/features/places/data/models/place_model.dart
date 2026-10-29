import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/place.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
abstract class PlaceModel with _$PlaceModel {
  const factory PlaceModel({
    required String id,
    required String name,
    String? type,
    String? categoryName,
    String? shortDescription,
    String? description,
    String? address,
    String? phone,
    String? openingHours,
    double? latitude,
    double? longitude,
    String? thumbnailUrl,
    @Default(<String>[]) List<String> imageUrls,
    String? districtId,
    String? districtName,
    @Default(false) bool isFeatured,
    String? updatedAt,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}

extension PlaceModelMapper on PlaceModel {
  Place toEntity() {
    return Place(
      id: id,
      name: name,
      type: type,
      categoryName: categoryName,
      shortDescription: shortDescription,
      description: description,
      address: address,
      phone: phone,
      openingHours: openingHours,
      latitude: latitude,
      longitude: longitude,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      districtId: districtId,
      districtName: districtName,
      isFeatured: isFeatured,
      updatedAt: updatedAt,
    );
  }
}
