// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Database/firebase_db.dart';
import 'dart:io' show Platform;
import 'check_app_status.dart';
import 'check_app_update.dart';

Future<bool> updateAppConfigModel(BuildContext context) async {
  print('START: getAppConfig()');
  var jsonData = await Database.docData('config/appConfigDoc');
  var serverConfig = AppConfigModel.fromJson(jsonData ?? {});
  context.uniProvider.serverConfigUpdate(serverConfig);

  // Get & Update local version
  var packageInfo = await PackageInfo.fromPlatform();
  int buildNumber = int.parse(packageInfo.buildNumber);
  print('buildNumber $buildNumber');

  var localConfig = context.uniProvider.localConfig;
  localConfig = context.uniProvider.localVersionUpdate(localConfig.copyWith(
    publicVersionAndroid: buildNumber,
    publicVersionIos: buildNumber,
  ));

  // Make sure server ver > local ver.
  // await updateServerVersionIfNeeded(context, localConfig, serverConfig);
  // serverConfig = context.uniProvider.serverConfig!;

  checkForUpdate(context, localConfig, serverConfig);
  chekAppStatus(context, serverConfig);

  // false: stop the app.
  if (serverConfig.statusCode != 200) return false;
  if (context.uniProvider.localConfig.isUpdateAvailable! &&
      serverConfig.updateType == UpdateTypes.needed) return false;
  return true;
}
