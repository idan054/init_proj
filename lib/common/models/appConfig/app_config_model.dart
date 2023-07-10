// ignore_for_file: invalid_annotation_target, constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';
part 'app_config_model.freezed.dart';
part 'app_config_model.g.dart';

enum OsTypes { android, ios}
enum UpdateTypes { recommended, needed}


// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
//~ Don't forget to manually add in HIVE Model!
class AppConfigModel with _$AppConfigModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes Only
  const factory AppConfigModel({
    String? status,
    String? adStatus,
    int? statusCode,
    OsTypes? osType,
    int? publicVersionAndroid,
    int? publicVersionIos,
    String? whatsNew,
    UpdateTypes? updateType,
    bool? isUpdateAvailable,
    String? updateIosLink,
    String? updateAndroidLink,
    int? currentPatchNumber
  }) = _AppConfigModel;

  factory AppConfigModel.fromJson(Map<String, dynamic> json) => _$AppConfigModelFromJson(json);
}
