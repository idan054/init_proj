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
// required List<CommentsModel> comments,
  String get textContent => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
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
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {String textContent,
      String id,
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
    Object? isDarkText = null,
    Object? isSubPost = null,
    Object? enableLikes = null,
    Object? enableComments = null,
    Object? timestamp = freezed,
    Object? textAlign = null,
    Object? likeCounter = freezed,
    Object? likeByIds = null,
    Object? photoCover = freezed,
    Object? colorCover = freezed,
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
      isDarkText: null == isDarkText
          ? _value.isDarkText
          : isDarkText // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubPost: null == isSubPost
          ? _value.isSubPost
          : isSubPost // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLikes: null == enableLikes
          ? _value.enableLikes
          : enableLikes // ignore: cast_nullable_to_non_nullable
              as bool,
      enableComments: null == enableComments
          ? _value.enableComments
          : enableComments // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      textAlign: null == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String,
      likeCounter: freezed == likeCounter
          ? _value.likeCounter
          : likeCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      likeByIds: null == likeByIds
          ? _value.likeByIds
          : likeByIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoCover: freezed == photoCover
          ? _value.photoCover
          : photoCover // ignore: cast_nullable_to_non_nullable
              as String?,
      colorCover: freezed == colorCover
          ? _value.colorCover
          : colorCover // ignore: cast_nullable_to_non_nullable
              as Color?,
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
    Object? isDarkText = null,
    Object? isSubPost = null,
    Object? enableLikes = null,
    Object? enableComments = null,
    Object? timestamp = freezed,
    Object? textAlign = null,
    Object? likeCounter = freezed,
    Object? likeByIds = null,
    Object? photoCover = freezed,
    Object? colorCover = freezed,
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
      isDarkText: null == isDarkText
          ? _value.isDarkText
          : isDarkText // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubPost: null == isSubPost
          ? _value.isSubPost
          : isSubPost // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLikes: null == enableLikes
          ? _value.enableLikes
          : enableLikes // ignore: cast_nullable_to_non_nullable
              as bool,
      enableComments: null == enableComments
          ? _value.enableComments
          : enableComments // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      textAlign: null == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String,
      likeCounter: freezed == likeCounter
          ? _value.likeCounter
          : likeCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      likeByIds: null == likeByIds
          ? _value._likeByIds
          : likeByIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoCover: freezed == photoCover
          ? _value.photoCover
          : photoCover // ignore: cast_nullable_to_non_nullable
              as String?,
      colorCover: freezed == colorCover
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
      this.id = '',
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
  final String id;
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
    if (_likeByIds is EqualUnmodifiableListView) return _likeByIds;
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
    return 'PostModel(textContent: $textContent, id: $id, creatorUser: $creatorUser, isDarkText: $isDarkText, isSubPost: $isSubPost, enableLikes: $enableLikes, enableComments: $enableComments, timestamp: $timestamp, textAlign: $textAlign, likeCounter: $likeCounter, likeByIds: $likeByIds, photoCover: $photoCover, colorCover: $colorCover)';
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
            (identical(other.isDarkText, isDarkText) ||
                other.isDarkText == isDarkText) &&
            (identical(other.isSubPost, isSubPost) ||
                other.isSubPost == isSubPost) &&
            (identical(other.enableLikes, enableLikes) ||
                other.enableLikes == enableLikes) &&
            (identical(other.enableComments, enableComments) ||
                other.enableComments == enableComments) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.likeCounter, likeCounter) ||
                other.likeCounter == likeCounter) &&
            const DeepCollectionEquality()
                .equals(other._likeByIds, _likeByIds) &&
            (identical(other.photoCover, photoCover) ||
                other.photoCover == photoCover) &&
            (identical(other.colorCover, colorCover) ||
                other.colorCover == colorCover));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      textContent,
      id,
      creatorUser,
      isDarkText,
      isSubPost,
      enableLikes,
      enableComments,
      timestamp,
      textAlign,
      likeCounter,
      const DeepCollectionEquality().hash(_likeByIds),
      photoCover,
      colorCover);

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
  String get id;
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
