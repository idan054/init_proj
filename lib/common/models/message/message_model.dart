// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class MessageModel with _$MessageModel {
  // @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory MessageModel({
    required String textContent,
    required String fromId,
    required String toId,
    required String createdAt,
    @DateTimeStampConv() required DateTime timestamp,
    String? messageId, // Cuz new field, was not exist at begging
    bool? read,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
