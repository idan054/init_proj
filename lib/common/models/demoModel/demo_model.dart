import 'package:freezed_annotation/freezed_annotation.dart';
part 'demo_model.g.dart';
part 'demo_model.freezed.dart';

@freezed
class DemoModel with _$DemoModel {
  const factory DemoModel.demo_model({
    required dynamic ID,
    required dynamic PointID,
    required dynamic CityName,
    required dynamic Time,
  }) = _DemoModel;

  factory DemoModel.fromJson(Map<String, dynamic> json) =>
      _$DemoModelFromJson(json);

}

//  required String id,
// required String pointId,
// required String streetName,
// required String streetNum,
// required dynamic latitude,
// required dynamic longitude,
// required String first1Last9,
// required int sortOrder,
// required dynamic errorCode,
// required String deliveryNumber,
// required String companyId,
// required String employeeId,
// required String sidurId,
// required int startTime,
// required int time,
// required int distance,