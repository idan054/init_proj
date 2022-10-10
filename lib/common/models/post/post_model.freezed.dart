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
  @HiveField(0)
  String get textContent => throw _privateConstructorUsedError;
  @HiveField(1)
  String get postId => throw _privateConstructorUsedError;
  @HiveField(2)
  UserModel? get creatorUser => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get isDarkText => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get isSubPost => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get enableLikes => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get enableComments => throw _privateConstructorUsedError;
  @HiveField(7)
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  @HiveField(8)
  TextAlign get textAlign => throw _privateConstructorUsedError;
  @HiveField(9)
  int? get likeCounter => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get photoCover => throw _privateConstructorUsedError;
  @HiveField(11)
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
      {@HiveField(0) String textContent,
      @HiveField(1) String postId,
      @HiveField(2) UserModel? creatorUser,
      @HiveField(3) bool isDarkText,
      @HiveField(4) bool isSubPost,
      @HiveField(5) bool enableLikes,
      @HiveField(6) bool enableComments,
      @HiveField(7) @DateTimeStampConv() DateTime? timestamp,
      @HiveField(8) TextAlign textAlign,
      @HiveField(9) int? likeCounter,
      @HiveField(10) String? photoCover,
      @HiveField(11) @ColorIntConv() Color? colorCover});

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
              as TextAlign,
      likeCounter: likeCounter == freezed
          ? _value.likeCounter
          : likeCounter // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {@HiveField(0) String textContent,
      @HiveField(1) String postId,
      @HiveField(2) UserModel? creatorUser,
      @HiveField(3) bool isDarkText,
      @HiveField(4) bool isSubPost,
      @HiveField(5) bool enableLikes,
      @HiveField(6) bool enableComments,
      @HiveField(7) @DateTimeStampConv() DateTime? timestamp,
      @HiveField(8) TextAlign textAlign,
      @HiveField(9) int? likeCounter,
      @HiveField(10) String? photoCover,
      @HiveField(11) @ColorIntConv() Color? colorCover});

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
              as TextAlign,
      likeCounter: likeCounter == freezed
          ? _value.likeCounter
          : likeCounter // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {@HiveField(0) this.textContent = '',
      @HiveField(1) this.postId = '',
      @HiveField(2) this.creatorUser,
      @HiveField(3) this.isDarkText = false,
      @HiveField(4) this.isSubPost = false,
      @HiveField(5) this.enableLikes = false,
      @HiveField(6) this.enableComments = false,
      @HiveField(7) @DateTimeStampConv() this.timestamp,
      @HiveField(8) this.textAlign = TextAlign.center,
      @HiveField(9) this.likeCounter,
      @HiveField(10) this.photoCover,
      @HiveField(11) @ColorIntConv() this.colorCover});

  factory _$_PostModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostModelFromJson(json);

// required List<CommentsModel> comments,
  @override
  @JsonKey()
  @HiveField(0)
  final String textContent;
  @override
  @JsonKey()
  @HiveField(1)
  final String postId;
  @override
  @HiveField(2)
  final UserModel? creatorUser;
  @override
  @JsonKey()
  @HiveField(3)
  final bool isDarkText;
  @override
  @JsonKey()
  @HiveField(4)
  final bool isSubPost;
  @override
  @JsonKey()
  @HiveField(5)
  final bool enableLikes;
  @override
  @JsonKey()
  @HiveField(6)
  final bool enableComments;
  @override
  @HiveField(7)
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  @JsonKey()
  @HiveField(8)
  final TextAlign textAlign;
  @override
  @HiveField(9)
  final int? likeCounter;
  @override
  @HiveField(10)
  final String? photoCover;
  @override
  @HiveField(11)
  @ColorIntConv()
  final Color? colorCover;

  @override
  String toString() {
    return 'PostModel(textContent: $textContent, postId: $postId, creatorUser: $creatorUser, isDarkText: $isDarkText, isSubPost: $isSubPost, enableLikes: $enableLikes, enableComments: $enableComments, timestamp: $timestamp, textAlign: $textAlign, likeCounter: $likeCounter, photoCover: $photoCover, colorCover: $colorCover)';
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
      {@HiveField(0) final String textContent,
      @HiveField(1) final String postId,
      @HiveField(2) final UserModel? creatorUser,
      @HiveField(3) final bool isDarkText,
      @HiveField(4) final bool isSubPost,
      @HiveField(5) final bool enableLikes,
      @HiveField(6) final bool enableComments,
      @HiveField(7) @DateTimeStampConv() final DateTime? timestamp,
      @HiveField(8) final TextAlign textAlign,
      @HiveField(9) final int? likeCounter,
      @HiveField(10) final String? photoCover,
      @HiveField(11) @ColorIntConv() final Color? colorCover}) = _$_PostModel;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$_PostModel.fromJson;

  @override // required List<CommentsModel> comments,
  @HiveField(0)
  String get textContent;
  @override
  @HiveField(1)
  String get postId;
  @override
  @HiveField(2)
  UserModel? get creatorUser;
  @override
  @HiveField(3)
  bool get isDarkText;
  @override
  @HiveField(4)
  bool get isSubPost;
  @override
  @HiveField(5)
  bool get enableLikes;
  @override
  @HiveField(6)
  bool get enableComments;
  @override
  @HiveField(7)
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  @HiveField(8)
  TextAlign get textAlign;
  @override
  @HiveField(9)
  int? get likeCounter;
  @override
  @HiveField(10)
  String? get photoCover;
  @override
  @HiveField(11)
  @ColorIntConv()
  Color? get colorCover;
  @override
  @JsonKey(ignore: true)
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
