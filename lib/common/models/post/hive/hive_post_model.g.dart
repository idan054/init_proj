// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelHiveAdapter extends TypeAdapter<PostModelHive> {
  @override
  final int typeId = 3;

  @override
  PostModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModelHive(
      textContent: fields[0] as String?,
      postId: fields[1] as String?,
      creatorUser: fields[2] as UserModelHive?,
      isDarkText: fields[3] as bool?,
      isSubPost: fields[4] as bool?,
      enableLikes: fields[5] as bool?,
      enableComments: fields[6] as bool?,
      timestamp: fields[7] as DateTime?,
      textAlign: fields[8] as String?,
      likeCounter: fields[9] as int?,
      photoCover: fields[10] as String?,
      colorCover: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PostModelHive obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.textContent)
      ..writeByte(1)
      ..write(obj.postId)
      ..writeByte(2)
      ..write(obj.creatorUser)
      ..writeByte(3)
      ..write(obj.isDarkText)
      ..writeByte(4)
      ..write(obj.isSubPost)
      ..writeByte(5)
      ..write(obj.enableLikes)
      ..writeByte(6)
      ..write(obj.enableComments)
      ..writeByte(7)
      ..write(obj.timestamp)
      ..writeByte(8)
      ..write(obj.textAlign)
      ..writeByte(9)
      ..write(obj.likeCounter)
      ..writeByte(10)
      ..write(obj.photoCover)
      ..writeByte(11)
      ..write(obj.colorCover);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
