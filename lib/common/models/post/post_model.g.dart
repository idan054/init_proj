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
      textAlign: $enumDecode(_$TextAlignEnumMap, json['textAlign']),
      isDarkText: json['isDarkText'] as bool,
      isSubPost: json['isSubPost'] as bool,
      enableLikes: json['enableLikes'] as bool,
      enableComments: json['enableComments'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      likeCounter: json['likeCounter'] as int?,
      photoCover: json['photoCover'] as String?,
      colorCover: const MyColorOrNullConverter()
          .fromJson(json['colorCover'] as String?),
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'textContent': instance.textContent,
      'postId': instance.postId,
      'creatorUser': instance.creatorUser.toJson(),
      'textAlign': _$TextAlignEnumMap[instance.textAlign]!,
      'isDarkText': instance.isDarkText,
      'isSubPost': instance.isSubPost,
      'enableLikes': instance.enableLikes,
      'enableComments': instance.enableComments,
      'timestamp': instance.timestamp.toIso8601String(),
      'likeCounter': instance.likeCounter,
      'photoCover': instance.photoCover,
      'colorCover': const MyColorOrNullConverter().toJson(instance.colorCover),
    };

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};
