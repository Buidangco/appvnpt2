// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceModel {

 String get id; String get name; String? get type; String? get categoryName; String? get shortDescription; String? get description; String? get address; String? get phone; String? get openingHours; double? get latitude; double? get longitude; String? get thumbnailUrl; List<String> get imageUrls; String? get districtId; String? get districtName; bool get isFeatured; String? get updatedAt;
/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceModelCopyWith<PlaceModel> get copyWith => _$PlaceModelCopyWithImpl<PlaceModel>(this as PlaceModel, _$identity);

  /// Serializes this PlaceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.districtId, districtId) || other.districtId == districtId)&&(identical(other.districtName, districtName) || other.districtName == districtName)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,categoryName,shortDescription,description,address,phone,openingHours,latitude,longitude,thumbnailUrl,const DeepCollectionEquality().hash(imageUrls),districtId,districtName,isFeatured,updatedAt);

@override
String toString() {
  return 'PlaceModel(id: $id, name: $name, type: $type, categoryName: $categoryName, shortDescription: $shortDescription, description: $description, address: $address, phone: $phone, openingHours: $openingHours, latitude: $latitude, longitude: $longitude, thumbnailUrl: $thumbnailUrl, imageUrls: $imageUrls, districtId: $districtId, districtName: $districtName, isFeatured: $isFeatured, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlaceModelCopyWith<$Res>  {
  factory $PlaceModelCopyWith(PlaceModel value, $Res Function(PlaceModel) _then) = _$PlaceModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? type, String? categoryName, String? shortDescription, String? description, String? address, String? phone, String? openingHours, double? latitude, double? longitude, String? thumbnailUrl, List<String> imageUrls, String? districtId, String? districtName, bool isFeatured, String? updatedAt
});




}
/// @nodoc
class _$PlaceModelCopyWithImpl<$Res>
    implements $PlaceModelCopyWith<$Res> {
  _$PlaceModelCopyWithImpl(this._self, this._then);

  final PlaceModel _self;
  final $Res Function(PlaceModel) _then;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = freezed,Object? categoryName = freezed,Object? shortDescription = freezed,Object? description = freezed,Object? address = freezed,Object? phone = freezed,Object? openingHours = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? thumbnailUrl = freezed,Object? imageUrls = null,Object? districtId = freezed,Object? districtName = freezed,Object? isFeatured = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,districtId: freezed == districtId ? _self.districtId : districtId // ignore: cast_nullable_to_non_nullable
as String?,districtName: freezed == districtName ? _self.districtName : districtName // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceModel].
extension PlaceModelPatterns on PlaceModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceModel value)  $default,){
final _that = this;
switch (_that) {
case _PlaceModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? type,  String? categoryName,  String? shortDescription,  String? description,  String? address,  String? phone,  String? openingHours,  double? latitude,  double? longitude,  String? thumbnailUrl,  List<String> imageUrls,  String? districtId,  String? districtName,  bool isFeatured,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.categoryName,_that.shortDescription,_that.description,_that.address,_that.phone,_that.openingHours,_that.latitude,_that.longitude,_that.thumbnailUrl,_that.imageUrls,_that.districtId,_that.districtName,_that.isFeatured,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? type,  String? categoryName,  String? shortDescription,  String? description,  String? address,  String? phone,  String? openingHours,  double? latitude,  double? longitude,  String? thumbnailUrl,  List<String> imageUrls,  String? districtId,  String? districtName,  bool isFeatured,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlaceModel():
return $default(_that.id,_that.name,_that.type,_that.categoryName,_that.shortDescription,_that.description,_that.address,_that.phone,_that.openingHours,_that.latitude,_that.longitude,_that.thumbnailUrl,_that.imageUrls,_that.districtId,_that.districtName,_that.isFeatured,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? type,  String? categoryName,  String? shortDescription,  String? description,  String? address,  String? phone,  String? openingHours,  double? latitude,  double? longitude,  String? thumbnailUrl,  List<String> imageUrls,  String? districtId,  String? districtName,  bool isFeatured,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.categoryName,_that.shortDescription,_that.description,_that.address,_that.phone,_that.openingHours,_that.latitude,_that.longitude,_that.thumbnailUrl,_that.imageUrls,_that.districtId,_that.districtName,_that.isFeatured,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceModel implements PlaceModel {
  const _PlaceModel({required this.id, required this.name, this.type, this.categoryName, this.shortDescription, this.description, this.address, this.phone, this.openingHours, this.latitude, this.longitude, this.thumbnailUrl, final  List<String> imageUrls = const <String>[], this.districtId, this.districtName, this.isFeatured = false, this.updatedAt}): _imageUrls = imageUrls;
  factory _PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? type;
@override final  String? categoryName;
@override final  String? shortDescription;
@override final  String? description;
@override final  String? address;
@override final  String? phone;
@override final  String? openingHours;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? thumbnailUrl;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override final  String? districtId;
@override final  String? districtName;
@override@JsonKey() final  bool isFeatured;
@override final  String? updatedAt;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceModelCopyWith<_PlaceModel> get copyWith => __$PlaceModelCopyWithImpl<_PlaceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.districtId, districtId) || other.districtId == districtId)&&(identical(other.districtName, districtName) || other.districtName == districtName)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,categoryName,shortDescription,description,address,phone,openingHours,latitude,longitude,thumbnailUrl,const DeepCollectionEquality().hash(_imageUrls),districtId,districtName,isFeatured,updatedAt);

@override
String toString() {
  return 'PlaceModel(id: $id, name: $name, type: $type, categoryName: $categoryName, shortDescription: $shortDescription, description: $description, address: $address, phone: $phone, openingHours: $openingHours, latitude: $latitude, longitude: $longitude, thumbnailUrl: $thumbnailUrl, imageUrls: $imageUrls, districtId: $districtId, districtName: $districtName, isFeatured: $isFeatured, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlaceModelCopyWith<$Res> implements $PlaceModelCopyWith<$Res> {
  factory _$PlaceModelCopyWith(_PlaceModel value, $Res Function(_PlaceModel) _then) = __$PlaceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? type, String? categoryName, String? shortDescription, String? description, String? address, String? phone, String? openingHours, double? latitude, double? longitude, String? thumbnailUrl, List<String> imageUrls, String? districtId, String? districtName, bool isFeatured, String? updatedAt
});




}
/// @nodoc
class __$PlaceModelCopyWithImpl<$Res>
    implements _$PlaceModelCopyWith<$Res> {
  __$PlaceModelCopyWithImpl(this._self, this._then);

  final _PlaceModel _self;
  final $Res Function(_PlaceModel) _then;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = freezed,Object? categoryName = freezed,Object? shortDescription = freezed,Object? description = freezed,Object? address = freezed,Object? phone = freezed,Object? openingHours = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? thumbnailUrl = freezed,Object? imageUrls = null,Object? districtId = freezed,Object? districtName = freezed,Object? isFeatured = null,Object? updatedAt = freezed,}) {
  return _then(_PlaceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,districtId: freezed == districtId ? _self.districtId : districtId // ignore: cast_nullable_to_non_nullable
as String?,districtName: freezed == districtName ? _self.districtName : districtName // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
