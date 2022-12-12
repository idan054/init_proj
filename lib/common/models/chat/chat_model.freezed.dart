// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  String? get id => throw _privateConstructorUsedError; // chat id
  MessageModel? get lastMessage => throw _privateConstructorUsedError;
  List<String>? get usersIds => throw _privateConstructorUsedError;
  List<UserModel>? get users => throw _privateConstructorUsedError;
  List<MessageModel>? get messages => throw _privateConstructorUsedError;
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {String? id,
      MessageModel? lastMessage,
      List<String>? usersIds,
      List<UserModel>? users,
      List<MessageModel>? messages,
      @DateTimeStampConv() DateTime? timestamp});

  $MessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? lastMessage = freezed,
    Object? usersIds = freezed,
    Object? users = freezed,
    Object? messages = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      usersIds: freezed == usersIds
          ? _value.usersIds
          : usersIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageModelCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageModelCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$$_ChatModelCopyWith(
          _$_ChatModel value, $Res Function(_$_ChatModel) then) =
      __$$_ChatModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      MessageModel? lastMessage,
      List<String>? usersIds,
      List<UserModel>? users,
      List<MessageModel>? messages,
      @DateTimeStampConv() DateTime? timestamp});

  @override
  $MessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$_ChatModelCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$_ChatModel>
    implements _$$_ChatModelCopyWith<$Res> {
  __$$_ChatModelCopyWithImpl(
      _$_ChatModel _value, $Res Function(_$_ChatModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? lastMessage = freezed,
    Object? usersIds = freezed,
    Object? users = freezed,
    Object? messages = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$_ChatModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      usersIds: freezed == usersIds
          ? _value._usersIds
          : usersIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      messages: freezed == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ChatModel implements _ChatModel {
  const _$_ChatModel(
      {this.id,
      this.lastMessage,
      final List<String>? usersIds,
      final List<UserModel>? users,
      final List<MessageModel>? messages,
      @DateTimeStampConv() this.timestamp})
      : _usersIds = usersIds,
        _users = users,
        _messages = messages;

  factory _$_ChatModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatModelFromJson(json);

  @override
  final String? id;
// chat id
  @override
  final MessageModel? lastMessage;
  final List<String>? _usersIds;
  @override
  List<String>? get usersIds {
    final value = _usersIds;
    if (value == null) return null;
    if (_usersIds is EqualUnmodifiableListView) return _usersIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserModel>? _users;
  @override
  List<UserModel>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MessageModel>? _messages;
  @override
  List<MessageModel>? get messages {
    final value = _messages;
    if (value == null) return null;
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @DateTimeStampConv()
  final DateTime? timestamp;

  @override
  String toString() {
    return 'ChatModel(id: $id, lastMessage: $lastMessage, usersIds: $usersIds, users: $users, messages: $messages, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality().equals(other._usersIds, _usersIds) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lastMessage,
      const DeepCollectionEquality().hash(_usersIds),
      const DeepCollectionEquality().hash(_users),
      const DeepCollectionEquality().hash(_messages),
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      __$$_ChatModelCopyWithImpl<_$_ChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatModelToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {final String? id,
      final MessageModel? lastMessage,
      final List<String>? usersIds,
      final List<UserModel>? users,
      final List<MessageModel>? messages,
      @DateTimeStampConv() final DateTime? timestamp}) = _$_ChatModel;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$_ChatModel.fromJson;

  @override
  String? get id;
  @override // chat id
  MessageModel? get lastMessage;
  @override
  List<String>? get usersIds;
  @override
  List<UserModel>? get users;
  @override
  List<MessageModel>? get messages;
  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
