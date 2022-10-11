// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
// required List<CommentsModel> comments,
  String get textContent => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  UserModel? get creatorUser => throw _privateConstructorUsedError;
  bool get isDarkText => throw _privateConstructorUsedError;
  bool get isSubPost => throw _privateConstructorUsedError;
  bool get enableLikes => throw _privateConstructorUsedError;
  bool get enableComments => throw _privateConstructorUsedError;
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  String get textAlign => throw _privateConstructorUsedError;
  int? get likeCounter => throw _privateConstructorUsedError;
  List<String> get likeByIds => throw _privateConstructorUsedError;
  String? get photoCover => throw _privateConstructorUsedError;
  @ColorIntConv()
  Color? get colorCover => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res>;
  $Res call(
      {String textContent,
      String postId,
      UserModel? creatorUser,
      bool isDarkText,
      bool isSubPost,
      bool enableLikes,
      bool enableComments,
      @DateTimeStampConv() DateTime? timestamp,
      String textAlign,
      int? likeCounter,
      List<String> likeByIds,
      String? photoCover,
      @ColorIntConv() Color? colorCover});

  $UserModelCopyWith<$Res>? get creatorUser;
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res> implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  final PostModel _value;
  // ignore: unused_field
  final $Res Function(PostModel) _then;

  @override
  $Res call({
    Object? textContent = freezed,
    Object? postId = freezed,
    Object? creatorUser = freezed,
    Object? isDarkText = freezed,
    Object? isSubPost = freezed,
    Object? enableLikes = freezed,
    Object? enableComments = freezed,
    Object? timestamp = freezed,
    Object? textAlign = freezed,
    Object? likeCounter = freezed,
    Object? likeByIds = freezed,
    Object? photoCover = freezed,
    Object? colorCover = freezed,
  }) {
    return _then(_value.copyWith(
      textContent: textContent == freezed
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUser: creatorUser == freezed
          ? _value.creatorUser
          : creatorUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      isDarkText: isDarkText == freezed
          ? _value.isDarkText
          : isDarkText // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubPost: isSubPost == freezed
          ? _value.isSubPost
          : isSubPost // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLikes: enableLikes == freezed
          ? _value.enableLikes
          : enableLikes // ignore: cast_nullable_to_non_nullable
              as bool,
      enableComments: enableComments == freezed
          ? _value.enableComments
          : enableComments // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      textAlign: textAlign == freezed
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String,
      likeCounter: likeCounter == freezed
          ? _value.likeCounter
          : likeCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      likeByIds: likeByIds == freezed
          ? _value.likeByIds
          : likeByIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoCover: photoCover == freezed
          ? _value.photoCover
          : photoCover // ignore: cast_nullable_to_non_nullable
              as String?,
      colorCover: colorCover == freezed
          ? _value.colorCover
          : colorCover // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }

  @override
  $UserModelCopyWith<$Res>? get creatorUser {
    if (_value.creatorUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.creatorUser!, (value) {
      return _then(_value.copyWith(creatorUser: value));
    });
  }
}

/// @nodoc
abstract class _$$_PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$$_PostModelCopyWith(
          _$_PostModel value, $Res Function(_$_PostModel) then) =
      __$$_PostModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String textContent,
      String postId,
      UserModel? creatorUser,
      bool isDarkText,
      bool isSubPost,
      bool enableLikes,
      bool enableComments,
      @DateTimeStampConv() DateTime? timestamp,
      String textAlign,
      int? likeCounter,
      List<String> likeByIds,
      String? photoCover,
      @ColorIntConv() Color? colorCover});

  @override
  $UserModelCopyWith<$Res>? get creatorUser;
}

/// @nodoc
class __$$_PostModelCopyWithImpl<$Res> extends _$PostModelCopyWithImpl<$Res>
    implements _$$_PostModelCopyWith<$Res> {
  __$$_PostModelCopyWithImpl(
      _$_PostModel _value, $Res Function(_$_PostModel) _then)
      : super(_value, (v) => _then(v as _$_PostModel));

  @override
  _$_PostModel get _value => super._value as _$_PostModel;

  @override
  $Res call({
    Object? textContent = freezed,
    Object? postId = freezed,
    Object? creatorUser = freezed,
    Object? isDarkText = freezed,
    Object? isSubPost = freezed,
    Object? enableLikes = freezed,
    Object? enableComments = freezed,
    Object? timestamp = freezed,
    Object? textAlign = freezed,
    Object? likeCounter = freezed,
    Object? likeByIds = freezed,
    Object? photoCover = freezed,
    Object? colorCover = freezed,
  }) {
    return _then(_$_PostModel(
      textContent: textContent == freezed
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUser: creatorUser == freezed
          ? _value.creatorUser
          : creatorUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      isDarkText: isDarkText == freezed
          ? _value.isDarkText
          : isDarkText // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubPost: isSubPost == freezed
          ? _value.isSubPost
          : isSubPost // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLikes: enableLikes == freezed
          ? _value.enableLikes
          : enableLikes // ignore: cast_nullable_to_non_nullable
              as bool,
      enableComments: enableComments == freezed
          ? _value.enableComments
          : enableComments // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      textAlign: textAlign == freezed
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String,
      likeCounter: likeCounter == freezed
          ? _value.likeCounter
          : likeCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      likeByIds: likeByIds == freezed
          ? _value._likeByIds
          : likeByIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoCover: photoCover == freezed
          ? _value.photoCover
          : photoCover // ignore: cast_nullable_to_non_nullable
              as String?,
      colorCover: colorCover == freezed
          ? _value.colorCover
          : colorCover // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PostModel implements _PostModel {
  const _$_PostModel(
      {this.textContent = '',
      this.postId = '',
      this.creatorUser,
      this.isDarkText = false,
      this.isSubPost = false,
      this.enableLikes = false,
      this.enableComments = false,
      @DateTimeStampConv() this.timestamp,
      this.textAlign = '',
      this.likeCounter,
      final List<String> likeByIds = const [],
      this.photoCover,
      @ColorIntConv() this.colorCover})
      : _likeByIds = likeByIds;

  factory _$_PostModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostModelFromJson(json);

// required List<CommentsModel> comments,
  @override
  @JsonKey()
  final String textContent;
  @override
  @JsonKey()
  final String postId;
  @override
  final UserModel? creatorUser;
  @override
  @JsonKey()
  final bool isDarkText;
  @override
  @JsonKey()
  final bool isSubPost;
  @override
  @JsonKey()
  final bool enableLikes;
  @override
  @JsonKey()
  final bool enableComments;
  @override
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  @JsonKey()
  final String textAlign;
  @override
  final int? likeCounter;
  final List<String> _likeByIds;
  @override
  @JsonKey()
  List<String> get likeByIds {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likeByIds);
  }

  @override
  final String? photoCover;
  @override
  @ColorIntConv()
  final Color? colorCover;

  @override
  String toString() {
    return 'PostModel(textContent: $textContent, postId: $postId, creatorUser: $creatorUser, isDarkText: $isDarkText, isSubPost: $isSubPost, enableLikes: $enableLikes, enableComments: $enableComments, timestamp: $timestamp, textAlign: $textAlign, likeCounter: $likeCounter, likeByIds: $likeByIds, photoCover: $photoCover, colorCover: $colorCover)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostModel &&
            const DeepCollectionEquality()
                .equals(other.textContent, textContent) &&
            const DeepCollectionEquality().equals(other.postId, postId) &&
            const DeepCollectionEquality()
                .equals(other.creatorUser, creatorUser) &&
            const DeepCollectionEquality()
                .equals(other.isDarkText, isDarkText) &&
            const DeepCollectionEquality().equals(other.isSubPost, isSubPost) &&
            const DeepCollectionEquality()
                .equals(other.enableLikes, enableLikes) &&
            const DeepCollectionEquality()
                .equals(other.enableComments, enableComments) &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.textAlign, textAlign) &&
            const DeepCollectionEquality()
                .equals(other.likeCounter, likeCounter) &&
            const DeepCollectionEquality()
                .equals(other._likeByIds, _likeByIds) &&
            const DeepCollectionEquality()
                .equals(other.photoCover, photoCover) &&
            const DeepCollectionEquality()
                .equals(other.colorCover, colorCover));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(textContent),
      const DeepCollectionEquality().hash(postId),
      const DeepCollectionEquality().hash(creatorUser),
      const DeepCollectionEquality().hash(isDarkText),
      const DeepCollectionEquality().hash(isSubPost),
      const DeepCollectionEquality().hash(enableLikes),
      const DeepCollectionEquality().hash(enableComments),
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(textAlign),
      const DeepCollectionEquality().hash(likeCounter),
      const DeepCollectionEquality().hash(_likeByIds),
      const DeepCollectionEquality().hash(photoCover),
      const DeepCollectionEquality().hash(colorCover));

  @JsonKey(ignore: true)
  @override
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
      final String postId,
      final UserModel? creatorUser,
      final bool isDarkText,
      final bool isSubPost,
      final bool enableLikes,
      final bool enableComments,
      @DateTimeStampConv() final DateTime? timestamp,
      final String textAlign,
      final int? likeCounter,
      final List<String> likeByIds,
      final String? photoCover,
      @ColorIntConv() final Color? colorCover}) = _$_PostModel;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$_PostModel.fromJson;

  @override // required List<CommentsModel> comments,
  String get textContent;
  @override
  String get postId;
  @override
  UserModel? get creatorUser;
  @override
  bool get isDarkText;
  @override
  bool get isSubPost;
  @override
  bool get enableLikes;
  @override
  bool get enableComments;
  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  String get textAlign;
  @override
  int? get likeCounter;
  @override
  List<String> get likeByIds;
  @override
  String? get photoCover;
  @override
  @ColorIntConv()
  Color? get colorCover;
  @override
  @JsonKey(ignore: true)
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
