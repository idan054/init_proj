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
  String? get textContent => throw _privateConstructorUsedError;
  String? get fromId => throw _privateConstructorUsedError;
  String? get toId => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  String? get messageId =>
      throw _privateConstructorUsedError; // Cuz new field, was not exist at begging
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
      {String? textContent,
      String? fromId,
      String? toId,
      String? createdAt,
      @DateTimeStampConv() DateTime? timestamp,
      String? messageId,
      bool? read});
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
    Object? textContent = freezed,
    Object? fromId = freezed,
    Object? toId = freezed,
    Object? createdAt = freezed,
    Object? timestamp = freezed,
    Object? messageId = freezed,
    Object? read = freezed,
  }) {
    return _then(_value.copyWith(
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
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
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
      {String? textContent,
      String? fromId,
      String? toId,
      String? createdAt,
      @DateTimeStampConv() DateTime? timestamp,
      String? messageId,
      bool? read});
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
    Object? textContent = freezed,
    Object? fromId = freezed,
    Object? toId = freezed,
    Object? createdAt = freezed,
    Object? timestamp = freezed,
    Object? messageId = freezed,
    Object? read = freezed,
  }) {
    return _then(_$_MessageModel(
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
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageModel implements _MessageModel {
  const _$_MessageModel(
      {this.textContent,
      this.fromId,
      this.toId,
      this.createdAt,
      @DateTimeStampConv() this.timestamp,
      this.messageId,
      this.read});

  factory _$_MessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageModelFromJson(json);

  @override
  final String? textContent;
  @override
  final String? fromId;
  @override
  final String? toId;
  @override
  final String? createdAt;
  @override
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  final String? messageId;
// Cuz new field, was not exist at begging
  @override
  final bool? read;

  @override
  String toString() {
    return 'MessageModel(textContent: $textContent, fromId: $fromId, toId: $toId, createdAt: $createdAt, timestamp: $timestamp, messageId: $messageId, read: $read)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageModel &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.fromId, fromId) || other.fromId == fromId) &&
            (identical(other.toId, toId) || other.toId == toId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, textContent, fromId, toId,
      createdAt, timestamp, messageId, read);

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
      {final String? textContent,
      final String? fromId,
      final String? toId,
      final String? createdAt,
      @DateTimeStampConv() final DateTime? timestamp,
      final String? messageId,
      final bool? read}) = _$_MessageModel;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$_MessageModel.fromJson;

  @override
  String? get textContent;
  @override
  String? get fromId;
  @override
  String? get toId;
  @override
  String? get createdAt;
  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  String? get messageId;
  @override // Cuz new field, was not exist at begging
  bool? get read;
  @override
  @JsonKey(ignore: true)
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
