// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatModel _$$_ChatModelFromJson(Map<String, dynamic> json) => _$_ChatModel(
      id: json['id'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadCounter: json['unreadCounter'] as int?,
      usersIds: (json['usersIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChatModelToJson(_$_ChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastMessage': instance.lastMessage?.toJson(),
      'unreadCounter': instance.unreadCounter,
      'usersIds': instance.usersIds,
      'users': instance.users?.map((e) => e.toJson()).toList(),
      'messages': instance.messages?.map((e) => e.toJson()).toList(),
    };
