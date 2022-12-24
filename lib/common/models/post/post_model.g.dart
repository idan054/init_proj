// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      textContent: json['textContent'] as String? ?? '',
      id: json['id'] as String? ?? '',
      creatorUser: json['creatorUser'] == null
          ? null
          : UserModel.fromJson(json['creatorUser'] as Map<String, dynamic>),
      likeByIds: (json['likeByIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp?),
      isSubPost: json['isSubPost'] as bool? ?? false,
      enableComments: json['enableComments'] as bool? ?? false,
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'textContent': instance.textContent,
      'id': instance.id,
      'creatorUser': instance.creatorUser?.toJson(),
      'likeByIds': instance.likeByIds,
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'isSubPost': instance.isSubPost,
      'enableComments': instance.enableComments,
    };
