// ignore_for_file: invalid_annotation_target, constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';
part 'report_model.freezed.dart';
part 'report_model.g.dart';

enum ReportStatus {newReport, completedReport}
enum ReportType {ril, conversation, comment, user}

@freezed
//~ Don't forget to manually add in HIVE Model!
class ReportModel with _$ReportModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes Only
  const factory ReportModel({
    @DateTimeStampConv() DateTime? timestamp,
    String? id,
    String? reportedBy,
    String? reasonWhy,
    String? userName,
    ReportStatus? reportStatus,
    ReportType? reportType,
    PostModel? reportedPost,
    UserModel? reportedUser,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);
}
