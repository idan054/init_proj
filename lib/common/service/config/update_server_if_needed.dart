import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/service/config/check_app_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Database/firebase_db.dart';
import 'dart:io' show Platform;
import 'check_app_update.dart';

Future updateServerVersionIfNeeded(
  BuildContext context,
  AppConfigModel localConfig,
  AppConfigModel serverConfig,
) async {
  void updateServerConfig({required bool isIos})async {
    try {
      context.uniProvider.updateServerConfig(serverConfig.copyWith(
        publicVersionAndroid: localConfig.publicVersionAndroid,
        publicVersionIos: localConfig.publicVersionAndroid,
      ));

      var androidJson = {'publicVersionAndroid': localConfig.publicVersionAndroid!};
      var iosJson = {'publicVersionIos': localConfig.publicVersionIos!};

      await Database.updateFirestore(
          collection: 'config',
          docName: 'appConfigDoc',
          toJson: isIos ? iosJson : androidJson);
      // await Future.delayed(150.milliseconds);

    } catch (e, s) {
      // print(s);
    }
  }
  // V.Major.Minor.internal
  if (Platform.isAndroid) {
    if (localConfig.publicVersionAndroid! > serverConfig.publicVersionAndroid!) {
      printYellow('Android local version higher than server \\(*o*)/ Update server!');
      updateServerConfig(isIos: false);
    }
  }

  if (Platform.isIOS) {
    if (localConfig.publicVersionIos! > serverConfig.publicVersionIos!) {
      printYellow('IOS local version higher than server \\(*o*)/ Update server!');
      updateServerConfig(isIos: true);
    }
  }
}
