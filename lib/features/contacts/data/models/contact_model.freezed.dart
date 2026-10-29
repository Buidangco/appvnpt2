// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContactModel {

 String get id; String get name; String? get digitalExport; String? get address; String? get phone; String? get logoUrl; String? get website; String? get email; double? get latitude; double? get longitude;
/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactModelCopyWith<ContactModel> get copyWith => _$ContactModelCopyWithImpl<ContactModel>(this as ContactModel, _$identity);

  /// Serializes this ContactModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.digitalExport, digitalExport) || other.digitalExport == digitalExport)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.website, website) || other.website == website)&&(identical(other.email, email) || other.email == email)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,digitalExport,address,phone,logoUrl,website,email,latitude,longitude);

@override
String toString() {
  return 'ContactModel(id: $id, name: $name, digitalExport: $digitalExport, address: $address, phone: $phone, logoUrl: $logoUrl, website: $website, email: $email, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $ContactModelCopyWith<$Res>  {
  factory $ContactModelCopyWith(ContactModel value, $Res Function(ContactModel) _then) = _$ContactModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? digitalExport, String? address, String? phone, String? logoUrl, String? website, String? email, double? latitude, double? longitude
});




}
/// @nodoc
class _$ContactModelCopyWithImpl<$Res>
    implements $ContactModelCopyWith<$Res> {
  _$ContactModelCopyWithImpl(this._self, this._then);

  final ContactModel _self;
  final $Res Function(ContactModel) _then;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? digitalExport = freezed,Object? address = freezed,Object? phone = freezed,Object? logoUrl = freezed,Object? website = freezed,Object? email = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,digitalExport: freezed == digitalExport ? _self.digitalExport : digitalExport // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactModel].
extension ContactModelPatterns on ContactModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactModel value)  $default,){
final _that = this;
switch (_that) {
case _ContactModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? digitalExport,  String? address,  String? phone,  String? logoUrl,  String? website,  String? email,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that.id,_that.name,_that.digitalExport,_that.address,_that.phone,_that.logoUrl,_that.website,_that.email,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? digitalExport,  String? address,  String? phone,  String? logoUrl,  String? website,  String? email,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _ContactModel():
return $default(_that.id,_that.name,_that.digitalExport,_that.address,_that.phone,_that.logoUrl,_that.website,_that.email,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? digitalExport,  String? address,  String? phone,  String? logoUrl,  String? website,  String? email,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that.id,_that.name,_that.digitalExport,_that.address,_that.phone,_that.logoUrl,_that.website,_that.email,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactModel implements ContactModel {
  const _ContactModel({required this.id, required this.name, this.digitalExport, this.address, this.phone, this.logoUrl, this.website, this.email, this.latitude, this.longitude});
  factory _ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? digitalExport;
@override final  String? address;
@override final  String? phone;
@override final  String? logoUrl;
@override final  String? website;
@override final  String? email;
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactModelCopyWith<_ContactModel> get copyWith => __$ContactModelCopyWithImpl<_ContactModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.digitalExport, digitalExport) || other.digitalExport == digitalExport)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.website, website) || other.website == website)&&(identical(other.email, email) || other.email == email)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,digitalExport,address,phone,logoUrl,website,email,latitude,longitude);

@override
String toString() {
  return 'ContactModel(id: $id, name: $name, digitalExport: $digitalExport, address: $address, phone: $phone, logoUrl: $logoUrl, website: $website, email: $email, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$ContactModelCopyWith<$Res> implements $ContactModelCopyWith<$Res> {
  factory _$ContactModelCopyWith(_ContactModel value, $Res Function(_ContactModel) _then) = __$ContactModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? digitalExport, String? address, String? phone, String? logoUrl, String? website, String? email, double? latitude, double? longitude
});




}
/// @nodoc
class __$ContactModelCopyWithImpl<$Res>
    implements _$ContactModelCopyWith<$Res> {
  __$ContactModelCopyWithImpl(this._self, this._then);

  final _ContactModel _self;
  final $Res Function(_ContactModel) _then;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? digitalExport = freezed,Object? address = freezed,Object? phone = freezed,Object? logoUrl = freezed,Object? website = freezed,Object? email = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_ContactModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,digitalExport: freezed == digitalExport ? _self.digitalExport : digitalExport // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
