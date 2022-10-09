// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      textContent: json['textContent'] as String,
      postId: json['postId'] as String,
      creatorUser:
          UserModel.fromJson(json['creatorUser'] as Map<String, dynamic>),
      isDarkText: json['isDarkText'] as bool,
      isSubPost: json['isSubPost'] as bool,
      enableLikes: json['enableLikes'] as bool,
      enableComments: json['enableComments'] as bool,
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp),
      textAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['textAlign']) ??
          TextAlign.center,
      likeCounter: json['likeCounter'] as int?,
      photoCover: json['photoCover'] as String?,
      colorCover: _$JsonConverterFromJson<String, Color>(
          json['colorCover'], const ColorIntConv().fromJson),
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'textContent': instance.textContent,
      'postId': instance.postId,
      'creatorUser': instance.creatorUser.toJson(),
      'isDarkText': instance.isDarkText,
      'isSubPost': instance.isSubPost,
      'enableLikes': instance.enableLikes,
      'enableComments': instance.enableComments,
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'textAlign': _$TextAlignEnumMap[instance.textAlign]!,
      'likeCounter': instance.likeCounter,
      'photoCover': instance.photoCover,
      'colorCover': _$JsonConverterToJson<String, Color>(
          instance.colorCover, const ColorIntConv().toJson),
    };

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
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
