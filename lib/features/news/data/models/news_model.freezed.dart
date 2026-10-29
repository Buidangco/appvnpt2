// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsModel {

 String get id; String get title; String? get summary; String? get content; String? get contentType; String? get thumbnailUrl; List<String> get imageUrls; String? get categoryName; String? get publishedAt;
/// Create a copy of NewsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsModelCopyWith<NewsModel> get copyWith => _$NewsModelCopyWithImpl<NewsModel>(this as NewsModel, _$identity);

  /// Serializes this NewsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.content, content) || other.content == content)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,summary,content,contentType,thumbnailUrl,const DeepCollectionEquality().hash(imageUrls),categoryName,publishedAt);

@override
String toString() {
  return 'NewsModel(id: $id, title: $title, summary: $summary, content: $content, contentType: $contentType, thumbnailUrl: $thumbnailUrl, imageUrls: $imageUrls, categoryName: $categoryName, publishedAt: $publishedAt)';
}


}

/// @nodoc
abstract mixin class $NewsModelCopyWith<$Res>  {
  factory $NewsModelCopyWith(NewsModel value, $Res Function(NewsModel) _then) = _$NewsModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? summary, String? content, String? contentType, String? thumbnailUrl, List<String> imageUrls, String? categoryName, String? publishedAt
});




}
/// @nodoc
class _$NewsModelCopyWithImpl<$Res>
    implements $NewsModelCopyWith<$Res> {
  _$NewsModelCopyWithImpl(this._self, this._then);

  final NewsModel _self;
  final $Res Function(NewsModel) _then;

/// Create a copy of NewsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? summary = freezed,Object? content = freezed,Object? contentType = freezed,Object? thumbnailUrl = freezed,Object? imageUrls = null,Object? categoryName = freezed,Object? publishedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsModel].
extension NewsModelPatterns on NewsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsModel value)  $default,){
final _that = this;
switch (_that) {
case _NewsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsModel value)?  $default,){
final _that = this;
switch (_that) {
case _NewsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? summary,  String? content,  String? contentType,  String? thumbnailUrl,  List<String> imageUrls,  String? categoryName,  String? publishedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsModel() when $default != null:
return $default(_that.id,_that.title,_that.summary,_that.content,_that.contentType,_that.thumbnailUrl,_that.imageUrls,_that.categoryName,_that.publishedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? summary,  String? content,  String? contentType,  String? thumbnailUrl,  List<String> imageUrls,  String? categoryName,  String? publishedAt)  $default,) {final _that = this;
switch (_that) {
case _NewsModel():
return $default(_that.id,_that.title,_that.summary,_that.content,_that.contentType,_that.thumbnailUrl,_that.imageUrls,_that.categoryName,_that.publishedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? summary,  String? content,  String? contentType,  String? thumbnailUrl,  List<String> imageUrls,  String? categoryName,  String? publishedAt)?  $default,) {final _that = this;
switch (_that) {
case _NewsModel() when $default != null:
return $default(_that.id,_that.title,_that.summary,_that.content,_that.contentType,_that.thumbnailUrl,_that.imageUrls,_that.categoryName,_that.publishedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsModel implements NewsModel {
  const _NewsModel({required this.id, required this.title, this.summary, this.content, this.contentType, this.thumbnailUrl, final  List<String> imageUrls = const <String>[], this.categoryName, this.publishedAt}): _imageUrls = imageUrls;
  factory _NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? summary;
@override final  String? content;
@override final  String? contentType;
@override final  String? thumbnailUrl;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override final  String? categoryName;
@override final  String? publishedAt;

/// Create a copy of NewsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsModelCopyWith<_NewsModel> get copyWith => __$NewsModelCopyWithImpl<_NewsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.content, content) || other.content == content)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,summary,content,contentType,thumbnailUrl,const DeepCollectionEquality().hash(_imageUrls),categoryName,publishedAt);

@override
String toString() {
  return 'NewsModel(id: $id, title: $title, summary: $summary, content: $content, contentType: $contentType, thumbnailUrl: $thumbnailUrl, imageUrls: $imageUrls, categoryName: $categoryName, publishedAt: $publishedAt)';
}


}

/// @nodoc
abstract mixin class _$NewsModelCopyWith<$Res> implements $NewsModelCopyWith<$Res> {
  factory _$NewsModelCopyWith(_NewsModel value, $Res Function(_NewsModel) _then) = __$NewsModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? summary, String? content, String? contentType, String? thumbnailUrl, List<String> imageUrls, String? categoryName, String? publishedAt
});




}
/// @nodoc
class __$NewsModelCopyWithImpl<$Res>
    implements _$NewsModelCopyWith<$Res> {
  __$NewsModelCopyWithImpl(this._self, this._then);

  final _NewsModel _self;
  final $Res Function(_NewsModel) _then;

/// Create a copy of NewsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? summary = freezed,Object? content = freezed,Object? contentType = freezed,Object? thumbnailUrl = freezed,Object? imageUrls = null,Object? categoryName = freezed,Object? publishedAt = freezed,}) {
  return _then(_NewsModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
