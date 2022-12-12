import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Auth/auth_services.dart';
import 'package:example/common/service/mixins/after_layout_mixin.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/config.dart';
import '../../common/service/hive_services.dart';
import '../../widgets/my_widgets.dart';

Future splashInit(BuildContext context) async {
  print('FirebaseAuth.instance.currentUser?.uid ${FirebaseAuth.instance.currentUser?.uid}');
  if (FirebaseAuth.instance.currentUser?.uid != null) await AuthService.signInWithGoogle(context);

  await HiveServices.openBoxes();
  // if (clearHiveBoxes) await HiveServices.clearAllBoxes();
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayout {
  bool userLogged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      body: riltopiaLogo(fontSize: 32).center,
    ); // Splash here
  }

  @override
  void afterFirstLayout(BuildContext context) {
    userLogged = FirebaseAuth.instance.currentUser?.uid != null;
    splashInit(context).then((_) => userLogged
        ? context.router.replaceAll([DashboardRoute()])
        : context.router.replaceAll([const LoginRoute()]));
  }

  @override
  void didChangeDependencies() {
    Navigator.of(context);
    super.didChangeDependencies();
  }
}
