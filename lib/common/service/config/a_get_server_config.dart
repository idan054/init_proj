// ignore_for_file: use_build_context_synchronously

import 'package:example/common/service/config/check_app_status.dart';
import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/widgets/my_dialog.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Database/firebase_db.dart';
import 'dart:io' show Platform;
import 'check_app_update.dart';

Future<AppConfigModel> getAppConfig(BuildContext context) async {
  print('START: getAppConfig()');
  var jsonData = await Database.docData('config/appConfigDoc');
  var serverConfig = AppConfigModel.fromJson(jsonData ?? {});
  context.uniProvider.updateServerConfig(serverConfig);
  print('context.uniProvider.serverConfig?.adStatus ${context.uniProvider.serverConfig?.adStatus}');

  var localConfig = context.uniProvider.localConfig;
  //> Uncomment this to update server (& Edit uniProvider.localConfig)
  // Database.updateFirestore(collection: 'config', toJson: localConfig.toJson(), docName: 'appConfigDoc');

  chekForUpdate(context, localConfig, serverConfig);
  chekAppStatus(context, serverConfig);
  return serverConfig;
}
