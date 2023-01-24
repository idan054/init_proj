import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/widgets/my_dialog.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Database/firebase_db.dart';
import 'dart:io' show Platform;

void chekAppUpdate(
  BuildContext context,
  AppConfigModel localConfig,
  AppConfigModel serverConfig,
) async {
  var serverVer =
      Platform.isAndroid ? serverConfig.publicVersionAndroid : serverConfig.publicVersionIos;
  var localVer =
      Platform.isAndroid ? localConfig.publicVersionAndroid : localConfig.publicVersionIos;
  bool isUpdateNeeded = serverConfig.updateType == UpdateTypes.needed;
  var title = isUpdateNeeded ? 'Update needed' : 'Update found';

  context.uniProvider
      .updateLocalConfig(localConfig.copyWith(isUpdateAvailable: serverVer != localVer));

  print('localVer != serverVer ${localVer != serverVer}');
  if (localVer != serverVer) {
    print('START: localVer != serverVer()');
    showRilDialog(
      context,
      title: title,
      verticalMargin: 40,
      desc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Please update from V$localVer to V$serverVer\n'.toText(color: AppColors.grey50),
          'Whats new?'
                  ' \n${serverConfig.whatsNew}'
              .toTextExpanded(
            maxLines: 5,
            textAlign: TextAlign.left,
          ),
        ],
      ),
      secondaryBtn: TextButton(
          child: 'Update now'.toText(color: AppColors.primaryLight),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      barrierDismissible: serverConfig.updateType == UpdateTypes.recommended,
      showCancelBtn: serverConfig.updateType == UpdateTypes.recommended,
    );
  }
}
