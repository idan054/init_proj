// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      uid: json['uid'] as String?,
      photoUrl: json['photoUrl'] as String?,
      gender: $enumDecodeNullable(_$GenderTypesEnumMap, json['gender']),
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      age: json['age'] as int?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uid': instance.uid,
      'photoUrl': instance.photoUrl,
      'gender': _$GenderTypesEnumMap[instance.gender],
      'birthday': instance.birthday?.toIso8601String(),
      'age': instance.age,
    };

const _$GenderTypesEnumMap = {
  GenderTypes.boy: 'boy',
  GenderTypes.girl: 'girl',
  GenderTypes.lgbt: 'lgbt',
};
