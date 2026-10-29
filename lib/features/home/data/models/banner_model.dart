import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/home_banner.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
abstract class BannerModel with _$BannerModel {
  const factory BannerModel({
    required String id,
    required String title,
    required String imageUrl,
    String? linkType,
    String? linkId,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}

extension BannerModelMapper on BannerModel {
  HomeBanner toEntity() {
    return HomeBanner(
      id: id,
      title: title,
      imageUrl: imageUrl,
      linkType: linkType,
      linkId: linkId,
    );
  }
}
