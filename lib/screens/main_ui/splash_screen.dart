import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/mixins/after_layout_mixin.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../common/models/user/user_model.dart';
import '../../widgets/my_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayout {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      body: riltopiaLogo(fontSize: 32).center,
    ); // Splash here
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bool userLogged = FirebaseAuth.instance.currentUser?.uid != null;
    // if (userLogged) {}

    mySplashAsync().then(
      (_) => context.router.replaceAll(
          [userLogged ? const DashboardRoute() : const LoginRoute()]),
    );
  }

  Future mySplashAsync() async {
    await getUserLocallyData();
  }

  Future getUserLocallyData() async {
    final uniBox = await Hive.openBox('uniBox');
    var currUserJson = Map<String, dynamic>.from(uniBox.get('currUserJson'));
    var currUser = UserModel.fromJson(currUserJson);
    context.uniProvider.updateUser(currUser);
  }
}
