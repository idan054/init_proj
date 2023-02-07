import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Database/firebase_db.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

void checkForUpdate(
  BuildContext context,
  AppConfigModel localConfig,
  AppConfigModel serverConfig, {
  bool mustShowPopup = false,
}) async {
  var serverVer =
      Platform.isAndroid ? serverConfig.publicVersionAndroid : serverConfig.publicVersionIos;
  var localVer =
      Platform.isAndroid ? localConfig.publicVersionAndroid : localConfig.publicVersionIos;
  bool isUpdateNeeded = serverConfig.updateType == UpdateTypes.needed;
  var title = isUpdateNeeded ? 'Update needed' : 'Update found';
  var updateLink = Uri.parse(
    Platform.isAndroid ? serverConfig.updateAndroidLink ?? '' : serverConfig.updateIosLink ?? '',
  );

  context.uniProvider
      .localVersionUpdate(localConfig.copyWith(isUpdateAvailable: serverVer != localVer));

  localVer = (localVer ?? 1).toInt();
  serverVer = (serverVer ?? 1).toInt();
  if (localVer < serverVer || mustShowPopup) {
    print('START: localVer != serverVer()');
    showRilDialog(
      context,
      title: mustShowPopup ? 'Whats new' : title,
      verticalMargin: 40,
      desc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Please update from V$localVer to V$serverVer'.toText(color: AppColors.grey50),
          // '\n${mustShowPopup ? 'Whats new?' : ''}'
          (serverConfig.whatsNew ?? '')
              // .toTextExpanded(
              .toText(
            maxLines: 5,
            textAlign: TextAlign.left,
          ),
        ],
      ),
      secondaryBtn: mustShowPopup
          ? const Offstage()
          : TextButton(
              child: 'Update now'.toText(color: AppColors.primaryLight),
              onPressed: () {
                launchUrl(updateLink, mode: LaunchMode.externalApplication);
                Navigator.of(context).pop();
              }),
      barrierDismissible: mustShowPopup || serverConfig.updateType == UpdateTypes.recommended,
      showCancelBtn: mustShowPopup || serverConfig.updateType == UpdateTypes.recommended,
    );
  }
}
