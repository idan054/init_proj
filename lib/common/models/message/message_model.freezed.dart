// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  @HiveField(0)
  String? get textContent => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get fromId => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get toId => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get createdAt => throw _privateConstructorUsedError;
  @HiveField(4)
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get messageId =>
      throw _privateConstructorUsedError; // Cuz new field, was not exist at begging
  @HiveField(6)
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
      _$MessageModelCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String? textContent,
      @HiveField(1) String? fromId,
      @HiveField(2) String? toId,
      @HiveField(3) String? createdAt,
      @HiveField(4) @DateTimeStampConv() DateTime? timestamp,
      @HiveField(5) String? messageId,
      @HiveField(6) bool? read});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res> implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  final MessageModel _value;
  // ignore: unused_field
  final $Res Function(MessageModel) _then;

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
      textContent: textContent == freezed
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      fromId: fromId == freezed
          ? _value.fromId
          : fromId // ignore: cast_nullable_to_non_nullable
              as String?,
      toId: toId == freezed
          ? _value.toId
          : toId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      messageId: messageId == freezed
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      read: read == freezed
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageModelCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$_MessageModelCopyWith(
          _$_MessageModel value, $Res Function(_$_MessageModel) then) =
      __$$_MessageModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String? textContent,
      @HiveField(1) String? fromId,
      @HiveField(2) String? toId,
      @HiveField(3) String? createdAt,
      @HiveField(4) @DateTimeStampConv() DateTime? timestamp,
      @HiveField(5) String? messageId,
      @HiveField(6) bool? read});
}

/// @nodoc
class __$$_MessageModelCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res>
    implements _$$_MessageModelCopyWith<$Res> {
  __$$_MessageModelCopyWithImpl(
      _$_MessageModel _value, $Res Function(_$_MessageModel) _then)
      : super(_value, (v) => _then(v as _$_MessageModel));

  @override
  _$_MessageModel get _value => super._value as _$_MessageModel;

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
      textContent: textContent == freezed
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      fromId: fromId == freezed
          ? _value.fromId
          : fromId // ignore: cast_nullable_to_non_nullable
              as String?,
      toId: toId == freezed
          ? _value.toId
          : toId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      messageId: messageId == freezed
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      read: read == freezed
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
      {@HiveField(0) this.textContent,
      @HiveField(1) this.fromId,
      @HiveField(2) this.toId,
      @HiveField(3) this.createdAt,
      @HiveField(4) @DateTimeStampConv() this.timestamp,
      @HiveField(5) this.messageId,
      @HiveField(6) this.read});

  factory _$_MessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageModelFromJson(json);

  @override
  @HiveField(0)
  final String? textContent;
  @override
  @HiveField(1)
  final String? fromId;
  @override
  @HiveField(2)
  final String? toId;
  @override
  @HiveField(3)
  final String? createdAt;
  @override
  @HiveField(4)
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  @HiveField(5)
  final String? messageId;
// Cuz new field, was not exist at begging
  @override
  @HiveField(6)
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
            const DeepCollectionEquality()
                .equals(other.textContent, textContent) &&
            const DeepCollectionEquality().equals(other.fromId, fromId) &&
            const DeepCollectionEquality().equals(other.toId, toId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.messageId, messageId) &&
            const DeepCollectionEquality().equals(other.read, read));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(textContent),
      const DeepCollectionEquality().hash(fromId),
      const DeepCollectionEquality().hash(toId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(messageId),
      const DeepCollectionEquality().hash(read));

  @JsonKey(ignore: true)
  @override
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
      {@HiveField(0) final String? textContent,
      @HiveField(1) final String? fromId,
      @HiveField(2) final String? toId,
      @HiveField(3) final String? createdAt,
      @HiveField(4) @DateTimeStampConv() final DateTime? timestamp,
      @HiveField(5) final String? messageId,
      @HiveField(6) final bool? read}) = _$_MessageModel;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$_MessageModel.fromJson;

  @override
  @HiveField(0)
  String? get textContent;
  @override
  @HiveField(1)
  String? get fromId;
  @override
  @HiveField(2)
  String? get toId;
  @override
  @HiveField(3)
  String? get createdAt;
  @override
  @HiveField(4)
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  @HiveField(5)
  String? get messageId;
  @override // Cuz new field, was not exist at begging
  @HiveField(6)
  bool? get read;
  @override
  @JsonKey(ignore: true)
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
