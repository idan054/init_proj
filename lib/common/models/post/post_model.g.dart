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
      isDarkText: json['isDarkText'] as bool? ?? false,
      isSubPost: json['isSubPost'] as bool? ?? false,
      enableLikes: json['enableLikes'] as bool? ?? false,
      enableComments: json['enableComments'] as bool? ?? false,
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp?),
      textAlign: json['textAlign'] as String? ?? '',
      likeCounter: json['likeCounter'] as int?,
      likeByIds: (json['likeByIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      photoCover: json['photoCover'] as String?,
      colorCover: _$JsonConverterFromJson<String, Color>(
          json['colorCover'], const ColorIntConv().fromJson),
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'textContent': instance.textContent,
      'id': instance.id,
      'creatorUser': instance.creatorUser?.toJson(),
      'isDarkText': instance.isDarkText,
      'isSubPost': instance.isSubPost,
      'enableLikes': instance.enableLikes,
      'enableComments': instance.enableComments,
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'textAlign': instance.textAlign,
      'likeCounter': instance.likeCounter,
      'likeByIds': instance.likeByIds,
      'photoCover': instance.photoCover,
      'colorCover': _$JsonConverterToJson<String, Color>(
          instance.colorCover, const ColorIntConv().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
