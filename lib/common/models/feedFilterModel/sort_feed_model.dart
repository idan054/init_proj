// ignore_for_file: invalid_annotation_target, constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../service/mixins/assets.gen.dart';
import '../convertors.dart';
part 'sort_feed_model.freezed.dart';
part 'sort_feed_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@Freezed(toJson: true)
//~ Don't forget to manually add in HIVE Model!
class SortFeedModel with _$SortFeedModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes Only
  const factory SortFeedModel({
    required String title,
    required String desc,
    required SvgGenImage svg,
    required FilterTypes type,
  }) = _SortFeedModel;

  factory SortFeedModel.fromJson(Map<String, dynamic> json) => _$SortFeedModelFromJson(json);
}
