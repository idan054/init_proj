// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      tag: json['tag'] as String?,
      creatorUser: json['creatorUser'] == null
          ? null
          : UserModel.fromJson(json['creatorUser'] as Map<String, dynamic>),
      textContent: json['textContent'] as String? ?? '',
      id: json['id'] as String? ?? '',
      likeByIds: (json['likeByIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp?),
      enableComments: json['enableComments'] as bool? ?? false,
      originalPostId: json['originalPostId'] as String?,
      commentsLength: json['commentsLength'] as int? ?? 0,
      commentedUsersEmails: (json['commentedUsersEmails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      postType: $enumDecodeNullable(_$PostTypeEnumMap, json['postType']) ??
          PostType.dmRil,
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'creatorUser': instance.creatorUser?.toJson(),
      'textContent': instance.textContent,
      'id': instance.id,
      'likeByIds': instance.likeByIds,
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'enableComments': instance.enableComments,
      'originalPostId': instance.originalPostId,
      'commentsLength': instance.commentsLength,
      'commentedUsersEmails': instance.commentedUsersEmails,
      'comments': instance.comments?.map((e) => e.toJson()).toList(),
      'postType': _$PostTypeEnumMap[instance.postType],
    };

const _$PostTypeEnumMap = {
  PostType.dmRil: 'dmRil',
  PostType.conversationRil: 'conversationRil',
  PostType.comment: 'comment',
};
