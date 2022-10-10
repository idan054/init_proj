// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelHiveAdapter extends TypeAdapter<MessageModelHive> {
  @override
  final int typeId = 4;

  @override
  MessageModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModelHive(
      textContent: fields[0] as String?,
      fromId: fields[1] as String?,
      toId: fields[2] as String?,
      createdAt: fields[3] as String?,
      timestamp: fields[4] as DateTime?,
      messageId: fields[5] as String?,
      read: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.textContent)
      ..writeByte(1)
      ..write(obj.fromId)
      ..writeByte(2)
      ..write(obj.toId)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.messageId)
      ..writeByte(6)
      ..write(obj.read);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
