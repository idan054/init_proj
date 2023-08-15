// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageModel _$$_MessageModelFromJson(Map<String, dynamic> json) =>
    _$_MessageModel(
      id: json['id'] as String?,
      textContent: json['textContent'] as String?,
      fromId: json['fromId'] as String?,
      toId: json['toId'] as String?,
      createdAt: json['createdAt'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      isPostComment: json['isPostComment'] as bool? ?? false,
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$$_MessageModelToJson(_$_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'textContent': instance.textContent,
      'fromId': instance.fromId,
      'toId': instance.toId,
      'createdAt': instance.createdAt,
      'isRead': instance.isRead,
      'metadata': instance.metadata,
      'isPostComment': instance.isPostComment,
      'read': instance.read,
    };
