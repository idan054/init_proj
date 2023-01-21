// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String? get id =>
      throw _privateConstructorUsedError; // Cuz new field, was not exist at begging
  String? get textContent => throw _privateConstructorUsedError;
  String? get fromId => throw _privateConstructorUsedError;
  String? get toId => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  PostModel? get postReply => throw _privateConstructorUsedError;
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  bool? get read => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call(
      {String? id,
      String? textContent,
      String? fromId,
      String? toId,
      String? createdAt,
      PostModel? postReply,
      @DateTimeStampConv() DateTime? timestamp,
      bool? read});

  $PostModelCopyWith<$Res>? get postReply;
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? textContent = freezed,
    Object? fromId = freezed,
    Object? toId = freezed,
    Object? createdAt = freezed,
    Object? postReply = freezed,
    Object? timestamp = freezed,
    Object? read = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      textContent: freezed == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      fromId: freezed == fromId
          ? _value.fromId
          : fromId // ignore: cast_nullable_to_non_nullable
              as String?,
      toId: freezed == toId
          ? _value.toId
          : toId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      postReply: freezed == postReply
          ? _value.postReply
          : postReply // ignore: cast_nullable_to_non_nullable
              as PostModel?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PostModelCopyWith<$Res>? get postReply {
    if (_value.postReply == null) {
      return null;
    }

    return $PostModelCopyWith<$Res>(_value.postReply!, (value) {
      return _then(_value.copyWith(postReply: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MessageModelCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$_MessageModelCopyWith(
          _$_MessageModel value, $Res Function(_$_MessageModel) then) =
      __$$_MessageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? textContent,
      String? fromId,
      String? toId,
      String? createdAt,
      PostModel? postReply,
      @DateTimeStampConv() DateTime? timestamp,
      bool? read});

  @override
  $PostModelCopyWith<$Res>? get postReply;
}

/// @nodoc
class __$$_MessageModelCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$_MessageModel>
    implements _$$_MessageModelCopyWith<$Res> {
  __$$_MessageModelCopyWithImpl(
      _$_MessageModel _value, $Res Function(_$_MessageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? textContent = freezed,
    Object? fromId = freezed,
    Object? toId = freezed,
    Object? createdAt = freezed,
    Object? postReply = freezed,
    Object? timestamp = freezed,
    Object? read = freezed,
  }) {
    return _then(_$_MessageModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      textContent: freezed == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      fromId: freezed == fromId
          ? _value.fromId
          : fromId // ignore: cast_nullable_to_non_nullable
              as String?,
      toId: freezed == toId
          ? _value.toId
          : toId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      postReply: freezed == postReply
          ? _value.postReply
          : postReply // ignore: cast_nullable_to_non_nullable
              as PostModel?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageModel implements _MessageModel {
  const _$_MessageModel(
      {this.id,
      this.textContent,
      this.fromId,
      this.toId,
      this.createdAt,
      this.postReply,
      @DateTimeStampConv() this.timestamp,
      this.read});

  factory _$_MessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageModelFromJson(json);

  @override
  final String? id;
// Cuz new field, was not exist at begging
  @override
  final String? textContent;
  @override
  final String? fromId;
  @override
  final String? toId;
  @override
  final String? createdAt;
  @override
  final PostModel? postReply;
  @override
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  final bool? read;

  @override
  String toString() {
    return 'MessageModel(id: $id, textContent: $textContent, fromId: $fromId, toId: $toId, createdAt: $createdAt, postReply: $postReply, timestamp: $timestamp, read: $read)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.fromId, fromId) || other.fromId == fromId) &&
            (identical(other.toId, toId) || other.toId == toId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.postReply, postReply) ||
                other.postReply == postReply) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, textContent, fromId, toId,
      createdAt, postReply, timestamp, read);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      __$$_MessageModelCopyWithImpl<_$_MessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageModelToJson(
      this,
    );
  }
}

abstract class _MessageModel implements MessageModel {
  const factory _MessageModel(
      {final String? id,
      final String? textContent,
      final String? fromId,
      final String? toId,
      final String? createdAt,
      final PostModel? postReply,
      @DateTimeStampConv() final DateTime? timestamp,
      final bool? read}) = _$_MessageModel;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$_MessageModel.fromJson;

  @override
  String? get id;
  @override // Cuz new field, was not exist at begging
  String? get textContent;
  @override
  String? get fromId;
  @override
  String? get toId;
  @override
  String? get createdAt;
  @override
  PostModel? get postReply;
  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  bool? get read;
  @override
  @JsonKey(ignore: true)
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
