// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io' show Platform;
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Auth/auth_services.dart';
import 'package:example/common/service/mixins/after_layout_mixin.dart';
import 'package:example/common/service/online_service.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/screens/main_ui/widgets/riv_splash_screen.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/appConfig/app_config_model.dart';
import '../Auth/dynamic_link_services.dart';
import '../Database/firebase_db.dart';
import '../../dump/hive_services.dart';
import '../../../widgets/my_widgets.dart';
import '../Auth/notifications_services.dart';
import 'a_get_server_config.dart';

Future initializeApp(BuildContext context) async {
  // await Future.delayed(3.seconds);
  // await HiveServices.openBoxes();
  // if (clearHiveBoxes) await HiveServices.clearAllBoxes();

  var succeed = await updateAppConfigModel(context);
  if (!succeed) return;

  //> First time:
  if (FirebaseAuth.instance.currentUser?.uid == null ||
      FirebaseAuth.instance.currentUser?.email == null) {
    context.router.replaceAll([const LoginRoute()]);
    return;
  }

  //> Next time:
  await AuthService.signInWith(context, autoSignIn: true);
}
