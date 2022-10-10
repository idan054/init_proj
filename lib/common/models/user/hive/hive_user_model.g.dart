// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelHiveAdapter extends TypeAdapter<UserModelHive> {
  @override
  final int typeId = 2;

  @override
  UserModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModelHive(
      email: fields[1] as String?,
      name: fields[0] as String?,
      photoUrl: fields[4] as String?,
      age: fields[3] as int?,
      uid: fields[2] as String?,
      birthday: fields[6] as DateTime?,
      gender: fields[5] as GenderTypes?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.photoUrl)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.birthday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenderTypesAdapter extends TypeAdapter<GenderTypes> {
  @override
  final int typeId = 1;

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
