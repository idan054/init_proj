// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  String get textContent => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  UserModel? get creatorUser => throw _privateConstructorUsedError;
  List<String> get likeByIds => throw _privateConstructorUsedError;
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  bool get enableComments => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {String textContent,
      String id,
      UserModel? creatorUser,
      List<String> likeByIds,
      @DateTimeStampConv() DateTime? timestamp,
      bool enableComments,
      String? tag});

  $UserModelCopyWith<$Res>? get creatorUser;
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textContent = null,
    Object? id = null,
    Object? creatorUser = freezed,
    Object? likeByIds = null,
    Object? timestamp = freezed,
    Object? enableComments = null,
    Object? tag = freezed,
  }) {
    return _then(_value.copyWith(
      textContent: null == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUser: freezed == creatorUser
          ? _value.creatorUser
          : creatorUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      likeByIds: null == likeByIds
          ? _value.likeByIds
          : likeByIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enableComments: null == enableComments
          ? _value.enableComments
          : enableComments // ignore: cast_nullable_to_non_nullable
              as bool,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get creatorUser {
    if (_value.creatorUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.creatorUser!, (value) {
      return _then(_value.copyWith(creatorUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$$_PostModelCopyWith(
          _$_PostModel value, $Res Function(_$_PostModel) then) =
      __$$_PostModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String textContent,
      String id,
      UserModel? creatorUser,
      List<String> likeByIds,
      @DateTimeStampConv() DateTime? timestamp,
      bool enableComments,
      String? tag});

  @override
  $UserModelCopyWith<$Res>? get creatorUser;
}

/// @nodoc
class __$$_PostModelCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$_PostModel>
    implements _$$_PostModelCopyWith<$Res> {
  __$$_PostModelCopyWithImpl(
      _$_PostModel _value, $Res Function(_$_PostModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textContent = null,
    Object? id = null,
    Object? creatorUser = freezed,
    Object? likeByIds = null,
    Object? timestamp = freezed,
    Object? enableComments = null,
    Object? tag = freezed,
  }) {
    return _then(_$_PostModel(
      textContent: null == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUser: freezed == creatorUser
          ? _value.creatorUser
          : creatorUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      likeByIds: null == likeByIds
          ? _value._likeByIds
          : likeByIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enableComments: null == enableComments
          ? _value.enableComments
          : enableComments // ignore: cast_nullable_to_non_nullable
              as bool,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PostModel implements _PostModel {
  const _$_PostModel(
      {this.textContent = '',
      this.id = '',
      this.creatorUser,
      final List<String> likeByIds = const [],
      @DateTimeStampConv() this.timestamp,
      this.enableComments = false,
      this.tag})
      : _likeByIds = likeByIds;

  factory _$_PostModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostModelFromJson(json);

  @override
  @JsonKey()
  final String textContent;
  @override
  @JsonKey()
  final String id;
  @override
  final UserModel? creatorUser;
  final List<String> _likeByIds;
  @override
  @JsonKey()
  List<String> get likeByIds {
    if (_likeByIds is EqualUnmodifiableListView) return _likeByIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likeByIds);
  }

  @override
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  @JsonKey()
  final bool enableComments;
  @override
  final String? tag;

  @override
  String toString() {
    return 'PostModel(textContent: $textContent, id: $id, creatorUser: $creatorUser, likeByIds: $likeByIds, timestamp: $timestamp, enableComments: $enableComments, tag: $tag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostModel &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorUser, creatorUser) ||
                other.creatorUser == creatorUser) &&
            const DeepCollectionEquality()
                .equals(other._likeByIds, _likeByIds) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.enableComments, enableComments) ||
                other.enableComments == enableComments) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      textContent,
      id,
      creatorUser,
      const DeepCollectionEquality().hash(_likeByIds),
      timestamp,
      enableComments,
      tag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      __$$_PostModelCopyWithImpl<_$_PostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostModelToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  const factory _PostModel(
      {final String textContent,
      final String id,
      final UserModel? creatorUser,
      final List<String> likeByIds,
      @DateTimeStampConv() final DateTime? timestamp,
      final bool enableComments,
      final String? tag}) = _$_PostModel;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$_PostModel.fromJson;

  @override
  String get textContent;
  @override
  String get id;
  @override
  UserModel? get creatorUser;
  @override
  List<String> get likeByIds;
  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  bool get enableComments;
  @override
  String? get tag;
  @override
  @JsonKey(ignore: true)
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
