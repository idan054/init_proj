// ignore_for_file: use_build_context_synchronously

import 'package:example/common/service/config/check_app_status.dart';
import 'package:example/common/service/config/update_server_if_needed.dart';
import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Database/firebase_db.dart';
import 'dart:io' show Platform;
import 'check_app_update.dart';

Future<AppConfigModel> updateAppConfigModel(BuildContext context) async {
  print('START: getAppConfig()');
  var jsonData = await Database.docData('config/appConfigDoc');
  var serverConfig = AppConfigModel.fromJson(jsonData ?? {});
  context.uniProvider.updateServerConfig(serverConfig);

  // Get & Update local version
  var localConfig = context.uniProvider.localConfig;
  var packageInfo = await PackageInfo.fromPlatform();
  int buildNumber = int.parse(packageInfo.buildNumber);
  print('buildNumber $buildNumber');

  context.uniProvider.updateLocalConfig(localConfig
      .copyWith(publicVersionAndroid: buildNumber, publicVersionIos: buildNumber));
  localConfig = context.uniProvider.localConfig;

  // Make sure server ver > local ver.
  await updateServerVersionIfNeeded(context, localConfig, serverConfig);
  serverConfig = context.uniProvider.serverConfig!;
  checkForUpdate(context, localConfig, serverConfig);
  chekAppStatus(context, serverConfig);
  return serverConfig;
}
