// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 3;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel();
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageModel _$$_MessageModelFromJson(Map<String, dynamic> json) =>
    _$_MessageModel(
      textContent: json['textContent'] as String?,
      fromId: json['fromId'] as String?,
      toId: json['toId'] as String?,
      createdAt: json['createdAt'] as String?,
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp?),
      messageId: json['messageId'] as String?,
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$$_MessageModelToJson(_$_MessageModel instance) =>
    <String, dynamic>{
      'textContent': instance.textContent,
      'fromId': instance.fromId,
      'toId': instance.toId,
      'createdAt': instance.createdAt,
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'messageId': instance.messageId,
      'read': instance.read,
    };
