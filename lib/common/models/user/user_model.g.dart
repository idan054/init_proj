// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel();
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenderTypesAdapter extends TypeAdapter<GenderTypes> {
  @override
  final int typeId = 5;

  @override
  GenderTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GenderTypes.boy;
      case 1:
        return GenderTypes.girl;
      case 2:
        return GenderTypes.lgbt;
      default:
        return GenderTypes.boy;
    }
  }

  @override
  void write(BinaryWriter writer, GenderTypes obj) {
    switch (obj) {
      case GenderTypes.boy:
        writer.writeByte(0);
        break;
      case GenderTypes.girl:
        writer.writeByte(1);
        break;
      case GenderTypes.lgbt:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
