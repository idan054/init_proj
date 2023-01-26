// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      bio: json['bio'] as String?,
      fcm: json['fcm'] as String?,
      age: json['age'] as int?,
      photoUrl: json['photoUrl'] as String?,
      isOnline: json['isOnline'] as bool?,
      unreadCounter: json['unreadCounter'] as int? ?? 0,
      gender: $enumDecodeNullable(_$GenderTypesEnumMap, json['gender']),
      userType: $enumDecodeNullable(_$UserTypesEnumMap, json['userType']) ??
          UserTypes.normal,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      birthday:
          const DateTimeStampConv().fromJson(json['birthday'] as Timestamp?),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'bio': instance.bio,
      'fcm': instance.fcm,
      'age': instance.age,
      'photoUrl': instance.photoUrl,
      'isOnline': instance.isOnline,
      'unreadCounter': instance.unreadCounter,
      'gender': _$GenderTypesEnumMap[instance.gender],
      'userType': _$UserTypesEnumMap[instance.userType],
      'tags': instance.tags,
      'birthday': const DateTimeStampConv().toJson(instance.birthday),
    };

const _$GenderTypesEnumMap = {
  GenderTypes.male: 'male',
  GenderTypes.female: 'female',
  GenderTypes.other: 'other',
};

const _$UserTypesEnumMap = {
  UserTypes.normal: 'normal',
  UserTypes.admin: 'admin',
  UserTypes.blocked: 'blocked',
};
