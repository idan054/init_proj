// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageModel _$$_MessageModelFromJson(Map<String, dynamic> json) =>
    _$_MessageModel(
      textContent: json['textContent'] as String,
      fromId: json['fromId'] as String,
      toId: json['toId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$$_MessageModelToJson(_$_MessageModel instance) =>
    <String, dynamic>{
      'textContent': instance.textContent,
      'fromId': instance.fromId,
      'toId': instance.toId,
      'createdAt': instance.createdAt.toIso8601String(),
      'read': instance.read,
    };
