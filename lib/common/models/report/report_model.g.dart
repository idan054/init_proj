// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReportModel _$$_ReportModelFromJson(Map<String, dynamic> json) =>
    _$_ReportModel(
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp?),
      reportedBy: json['reportedBy'] as String?,
      reasonWhy: json['reasonWhy'] as String?,
      userName: json['userName'] as String?,
      reportStatus:
          $enumDecodeNullable(_$ReportStatusEnumMap, json['reportStatus']),
      reportType: $enumDecodeNullable(_$ReportTypeEnumMap, json['reportType']),
      reportedPost: json['reportedPost'] == null
          ? null
          : PostModel.fromJson(json['reportedPost'] as Map<String, dynamic>),
      reportedUser: json['reportedUser'] == null
          ? null
          : UserModel.fromJson(json['reportedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ReportModelToJson(_$_ReportModel instance) =>
    <String, dynamic>{
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'reportedBy': instance.reportedBy,
      'reasonWhy': instance.reasonWhy,
      'userName': instance.userName,
      'reportStatus': _$ReportStatusEnumMap[instance.reportStatus],
      'reportType': _$ReportTypeEnumMap[instance.reportType],
      'reportedPost': instance.reportedPost?.toJson(),
      'reportedUser': instance.reportedUser?.toJson(),
    };

const _$ReportStatusEnumMap = {
  ReportStatus.newReport: 'newReport',
  ReportStatus.completedReport: 'completedReport',
};

const _$ReportTypeEnumMap = {
  ReportType.ril: 'ril',
  ReportType.conversation: 'conversation',
  ReportType.comment: 'comment',
  ReportType.user: 'user',
};
