import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/district.dart';

part 'district_model.freezed.dart';
part 'district_model.g.dart';

@freezed
abstract class DistrictModel with _$DistrictModel {
  const factory DistrictModel({required String id, required String name}) =
      _DistrictModel;

  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);
}

extension DistrictModelMapper on DistrictModel {
  District toEntity() => District(id: id, name: name);
}
