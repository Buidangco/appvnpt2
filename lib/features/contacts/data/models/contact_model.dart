import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/contact.dart';

part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
abstract class ContactModel with _$ContactModel {
  const factory ContactModel({
    required String id,
    required String name,
    String? digitalExport,
    String? address,
    String? phone,
    String? logoUrl,
    String? website,
    String? email,
    double? latitude,
    double? longitude,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
}

extension ContactModelMapper on ContactModel {
  Contact toEntity() {
    return Contact(
      id: id,
      name: name,
      digitalExport: digitalExport,
      address: address,
      phone: phone,
      logoUrl: logoUrl,
      website: website,
      email: email,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
