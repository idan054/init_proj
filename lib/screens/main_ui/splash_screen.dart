// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Auth/auth_services.dart';
import 'package:example/common/service/mixins/after_layout_mixin.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/screens/main_ui/widgets/riv_splash_screen.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/dump/hive_services.dart';
import '../../common/service/init/initialize_app.dart';
import '../../widgets/my_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// class _SplashScreenState extends State<SplashScreen> with AfterLayout {
class _SplashScreenState extends State<SplashScreen>
    with SplashScreenStateMixin, TickerProviderStateMixin {
  bool userLogged = false;

  @override
  void initState() {
    super.initState();
    initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: buildAnimation().center,
    ); // Splash here
  }
}
