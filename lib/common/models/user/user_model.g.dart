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
      birthday: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['birthday'], const DateTimeStampConv().fromJson),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uid': instance.uid,
      'age': instance.age,
      'photoUrl': instance.photoUrl,
      'gender': _$GenderTypesEnumMap[instance.gender],
      'birthday': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.birthday, const DateTimeStampConv().toJson),
    };

const _$GenderTypesEnumMap = {
  GenderTypes.boy: 'boy',
  GenderTypes.girl: 'girl',
  GenderTypes.lgbt: 'lgbt',
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
