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
  String? get tag => throw _privateConstructorUsedError;
  UserModel? get creatorUser => throw _privateConstructorUsedError;
  String get textContent => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<String> get likeByIds => throw _privateConstructorUsedError;
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  bool get enableComments =>
      throw _privateConstructorUsedError; //~ Comment variables:
  String? get originalPostId => throw _privateConstructorUsedError;
  int get commentsLength => throw _privateConstructorUsedError;
  List<String> get commentedUsersEmails =>
      throw _privateConstructorUsedError; // AKA conversion users
  List<PostModel>? get comments => throw _privateConstructorUsedError;
  PostType? get postType =>
      throw _privateConstructorUsedError; //~ Notification variables:
  int get notificationsCounter => throw _privateConstructorUsedError;

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
      {String? tag,
      UserModel? creatorUser,
      String textContent,
      String id,
      List<String> likeByIds,
      @DateTimeStampConv() DateTime? timestamp,
      bool enableComments,
      String? originalPostId,
      int commentsLength,
      List<String> commentedUsersEmails,
      List<PostModel>? comments,
      PostType? postType,
      int notificationsCounter});

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
    Object? tag = freezed,
    Object? creatorUser = freezed,
    Object? textContent = null,
    Object? id = null,
    Object? likeByIds = null,
    Object? timestamp = freezed,
    Object? enableComments = null,
    Object? originalPostId = freezed,
    Object? commentsLength = null,
    Object? commentedUsersEmails = null,
    Object? comments = freezed,
    Object? postType = freezed,
    Object? notificationsCounter = null,
  }) {
    return _then(_value.copyWith(
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorUser: freezed == creatorUser
          ? _value.creatorUser
          : creatorUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      textContent: null == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      originalPostId: freezed == originalPostId
          ? _value.originalPostId
          : originalPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      commentsLength: null == commentsLength
          ? _value.commentsLength
          : commentsLength // ignore: cast_nullable_to_non_nullable
              as int,
      commentedUsersEmails: null == commentedUsersEmails
          ? _value.commentedUsersEmails
          : commentedUsersEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<PostModel>?,
      postType: freezed == postType
          ? _value.postType
          : postType // ignore: cast_nullable_to_non_nullable
              as PostType?,
      notificationsCounter: null == notificationsCounter
          ? _value.notificationsCounter
          : notificationsCounter // ignore: cast_nullable_to_non_nullable
              as int,
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
      {String? tag,
      UserModel? creatorUser,
      String textContent,
      String id,
      List<String> likeByIds,
      @DateTimeStampConv() DateTime? timestamp,
      bool enableComments,
      String? originalPostId,
      int commentsLength,
      List<String> commentedUsersEmails,
      List<PostModel>? comments,
      PostType? postType,
      int notificationsCounter});

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
    Object? tag = freezed,
    Object? creatorUser = freezed,
    Object? textContent = null,
    Object? id = null,
    Object? likeByIds = null,
    Object? timestamp = freezed,
    Object? enableComments = null,
    Object? originalPostId = freezed,
    Object? commentsLength = null,
    Object? commentedUsersEmails = null,
    Object? comments = freezed,
    Object? postType = freezed,
    Object? notificationsCounter = null,
  }) {
    return _then(_$_PostModel(
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorUser: freezed == creatorUser
          ? _value.creatorUser
          : creatorUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      textContent: null == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      originalPostId: freezed == originalPostId
          ? _value.originalPostId
          : originalPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      commentsLength: null == commentsLength
          ? _value.commentsLength
          : commentsLength // ignore: cast_nullable_to_non_nullable
              as int,
      commentedUsersEmails: null == commentedUsersEmails
          ? _value._commentedUsersEmails
          : commentedUsersEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comments: freezed == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<PostModel>?,
      postType: freezed == postType
          ? _value.postType
          : postType // ignore: cast_nullable_to_non_nullable
              as PostType?,
      notificationsCounter: null == notificationsCounter
          ? _value.notificationsCounter
          : notificationsCounter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PostModel implements _PostModel {
  const _$_PostModel(
      {this.tag,
      this.creatorUser,
      this.textContent = '',
      this.id = '',
      final List<String> likeByIds = const [],
      @DateTimeStampConv() this.timestamp,
      this.enableComments = false,
      this.originalPostId,
      this.commentsLength = 0,
      final List<String> commentedUsersEmails = const [],
      final List<PostModel>? comments = const [],
      this.postType = PostType.dmRil,
      this.notificationsCounter = 0})
      : _likeByIds = likeByIds,
        _commentedUsersEmails = commentedUsersEmails,
        _comments = comments;

  factory _$_PostModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostModelFromJson(json);

  @override
  final String? tag;
  @override
  final UserModel? creatorUser;
  @override
  @JsonKey()
  final String textContent;
  @override
  @JsonKey()
  final String id;
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
//~ Comment variables:
  @override
  final String? originalPostId;
  @override
  @JsonKey()
  final int commentsLength;
  final List<String> _commentedUsersEmails;
  @override
  @JsonKey()
  List<String> get commentedUsersEmails {
    if (_commentedUsersEmails is EqualUnmodifiableListView)
      return _commentedUsersEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commentedUsersEmails);
  }

// AKA conversion users
  final List<PostModel>? _comments;
// AKA conversion users
  @override
  @JsonKey()
  List<PostModel>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final PostType? postType;
//~ Notification variables:
  @override
  @JsonKey()
  final int notificationsCounter;

  @override
  String toString() {
    return 'PostModel(tag: $tag, creatorUser: $creatorUser, textContent: $textContent, id: $id, likeByIds: $likeByIds, timestamp: $timestamp, enableComments: $enableComments, originalPostId: $originalPostId, commentsLength: $commentsLength, commentedUsersEmails: $commentedUsersEmails, comments: $comments, postType: $postType, notificationsCounter: $notificationsCounter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostModel &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.creatorUser, creatorUser) ||
                other.creatorUser == creatorUser) &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._likeByIds, _likeByIds) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.enableComments, enableComments) ||
                other.enableComments == enableComments) &&
            (identical(other.originalPostId, originalPostId) ||
                other.originalPostId == originalPostId) &&
            (identical(other.commentsLength, commentsLength) ||
                other.commentsLength == commentsLength) &&
            const DeepCollectionEquality()
                .equals(other._commentedUsersEmails, _commentedUsersEmails) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.postType, postType) ||
                other.postType == postType) &&
            (identical(other.notificationsCounter, notificationsCounter) ||
                other.notificationsCounter == notificationsCounter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tag,
      creatorUser,
      textContent,
      id,
      const DeepCollectionEquality().hash(_likeByIds),
      timestamp,
      enableComments,
      originalPostId,
      commentsLength,
      const DeepCollectionEquality().hash(_commentedUsersEmails),
      const DeepCollectionEquality().hash(_comments),
      postType,
      notificationsCounter);

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
      {final String? tag,
      final UserModel? creatorUser,
      final String textContent,
      final String id,
      final List<String> likeByIds,
      @DateTimeStampConv() final DateTime? timestamp,
      final bool enableComments,
      final String? originalPostId,
      final int commentsLength,
      final List<String> commentedUsersEmails,
      final List<PostModel>? comments,
      final PostType? postType,
      final int notificationsCounter}) = _$_PostModel;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$_PostModel.fromJson;

  @override
  String? get tag;
  @override
  UserModel? get creatorUser;
  @override
  String get textContent;
  @override
  String get id;
  @override
  List<String> get likeByIds;
  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  bool get enableComments;
  @override //~ Comment variables:
  String? get originalPostId;
  @override
  int get commentsLength;
  @override
  List<String> get commentedUsersEmails;
  @override // AKA conversion users
  List<PostModel>? get comments;
  @override
  PostType? get postType;
  @override //~ Notification variables:
  int get notificationsCounter;
  @override
  @JsonKey(ignore: true)
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
