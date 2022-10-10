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
      gender: $enumDecodeNullable(_$GenderTypesEnumMap, json['gender']),
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
      'gender': _$GenderTypesEnumMap[instance.gender],
      'birthday': const DateTimeStampConv().toJson(instance.birthday),
    };

const _$GenderTypesEnumMap = {
  GenderTypes.boy: 'boy',
  GenderTypes.girl: 'girl',
  GenderTypes.lgbt: 'lgbt',
};
