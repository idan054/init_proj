import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:flutter/services.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Database/firebase_db.dart';
import 'dart:io' show Platform;

void chekAppStatus(
  BuildContext context,
  AppConfigModel serverConfig,
) async {
  var isStatusOK = serverConfig.statusCode == 200;
  if(isStatusOK) return;

  showRilDialog(
    context,
    title: 'We have issues right now!',
    verticalMargin: 40,
    desc: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Please Check again later'.toText(color: AppColors.grey50),
        '${serverConfig.statusCode} Server issue details:'
            ' \n${serverConfig.status}'
            .toTextExpanded(
          maxLines: 5,
          textAlign: TextAlign.left,
        ),
      ],
    ),
    secondaryBtn: TextButton(
        child: 'Close RilTopia'.toText(color: AppColors.primaryLight),
        onPressed: () {
          SystemNavigator.pop();
        }),
    barrierDismissible: false,
    showCancelBtn: false,
  );
}
