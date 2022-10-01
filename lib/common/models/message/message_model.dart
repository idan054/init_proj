import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String textContent,
    required String fromId,
    required String toId,
    required DateTime createdAt,
    bool? read,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
