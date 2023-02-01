// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io' show Platform;
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Auth/auth_services.dart';
import 'package:example/common/service/mixins/after_layout_mixin.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/screens/main_ui/widgets/riv_splash_screen.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/config.dart';
import '../../common/models/appConfig/app_config_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/config/a_get_server_config.dart';
import '../../common/service/hive_services.dart';
import '../../widgets/my_widgets.dart';
import 'notifications_services.dart';

Future initializeApp(BuildContext context) async {
  // await Future.delayed(3.seconds);
  // await HiveServices.openBoxes();
  // if (clearHiveBoxes) await HiveServices.clearAllBoxes();

  var serverConfig = await updateAppConfigModel(context);
  var localConfig = context.uniProvider.localConfig; // getAppConfig() set localConfig.isUpdateAvailable!
  if (serverConfig.statusCode != 200) return;
  if (localConfig.isUpdateAvailable! && serverConfig.updateType == UpdateTypes.needed) return;

  //> First time:
  if (FirebaseAuth.instance.currentUser?.uid == null ||
      FirebaseAuth.instance.currentUser?.email == null) {
    context.router.replaceAll([const LoginRoute()]);
  } else {
    //> Next time:
    await AuthService.signInWith(context, autoSignIn: true);
    // context.router.replaceAll([DashboardRoute()]);
  }
}

//MARK: - Push notifications
void _setupNotifications() async {
  print('START: _setupNotifications()');
  await NotificationService.instance.requestPermission();

  NotificationService.instance.onNotificationReceived(
    onReceived: (RemoteMessage message) {

    },
  );
}