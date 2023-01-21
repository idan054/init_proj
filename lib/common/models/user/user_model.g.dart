// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      uid: json['uid'] as String?,
      age: json['age'] as int?,
      photoUrl: json['photoUrl'] as String?,
      onlineUser: json['onlineUser'] as bool?,
      gender: $enumDecodeNullable(_$GenderTypesEnumMap, json['gender']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      birthday:
          const DateTimeStampConv().fromJson(json['birthday'] as Timestamp?),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uid': instance.uid,
      'age': instance.age,
      'photoUrl': instance.photoUrl,
      'onlineUser': instance.onlineUser,
      'gender': _$GenderTypesEnumMap[instance.gender],
      'tags': instance.tags,
      'birthday': const DateTimeStampConv().toJson(instance.birthday),
    };

const _$GenderTypesEnumMap = {
  GenderTypes.male: 'male',
  GenderTypes.female: 'female',
  GenderTypes.other: 'other',
};
