// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../convertors.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
@HiveType(typeId: 3, adapterName: 'MessageModelAdapter')
class MessageModel with _$MessageModel {
  // @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory MessageModel({
    @HiveField(0) String? textContent,
    @HiveField(1) String? fromId,
    @HiveField(2) String? toId,
    @HiveField(3) String? createdAt,
    @HiveField(4) @DateTimeStampConv() DateTime? timestamp,
    @HiveField(5) String? messageId, // Cuz new field, was not exist at begging
    @HiveField(6) bool? read,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
