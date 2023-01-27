// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppConfigModel _$$_AppConfigModelFromJson(Map<String, dynamic> json) =>
    _$_AppConfigModel(
      status: json['status'] as String?,
      adStatus: json['adStatus'] as String?,
      statusCode: json['statusCode'] as int?,
      osType: $enumDecodeNullable(_$OsTypesEnumMap, json['osType']),
      publicVersionAndroid: json['publicVersionAndroid'] as int?,
      publicVersionIos: json['publicVersionIos'] as int?,
      whatsNew: json['whatsNew'] as String?,
      updateType: $enumDecodeNullable(_$UpdateTypesEnumMap, json['updateType']),
      isUpdateAvailable: json['isUpdateAvailable'] as bool?,
      updateIosLink: json['updateIosLink'] as String?,
      updateAndroidLink: json['updateAndroidLink'] as String?,
    );

Map<String, dynamic> _$$_AppConfigModelToJson(_$_AppConfigModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'adStatus': instance.adStatus,
      'statusCode': instance.statusCode,
      'osType': _$OsTypesEnumMap[instance.osType],
      'publicVersionAndroid': instance.publicVersionAndroid,
      'publicVersionIos': instance.publicVersionIos,
      'whatsNew': instance.whatsNew,
      'updateType': _$UpdateTypesEnumMap[instance.updateType],
      'isUpdateAvailable': instance.isUpdateAvailable,
      'updateIosLink': instance.updateIosLink,
      'updateAndroidLink': instance.updateAndroidLink,
    };

const _$OsTypesEnumMap = {
  OsTypes.android: 'android',
  OsTypes.ios: 'ios',
};

const _$UpdateTypesEnumMap = {
  UpdateTypes.recommended: 'recommended',
  UpdateTypes.needed: 'needed',
};