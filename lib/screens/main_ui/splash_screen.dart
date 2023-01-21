import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Auth/auth_services.dart';
import 'package:example/common/service/mixins/after_layout_mixin.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/screens/main_ui/widgets/riv_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/config.dart';
import '../../common/service/hive_services.dart';
import '../../widgets/my_widgets.dart';

Future splashInit(BuildContext context) async {
  // await Future.delayed(3.seconds);
  await HiveServices.openBoxes();
  // if (clearHiveBoxes) await HiveServices.clearAllBoxes();
  //> First time:
  if (FirebaseAuth.instance.currentUser?.uid == null) {
    context.router.replaceAll([const LoginRoute()]);
  } else {
    //> Next time:
    await AuthService.signInWithGoogle(context);
    // context.router.replaceAll([DashboardRoute()]);
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// class _SplashScreenState extends State<SplashScreen> with AfterLayout {
class _SplashScreenState extends State<SplashScreen> with SplashScreenStateMixin, TickerProviderStateMixin {
  bool userLogged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      // body: riltopiaLogo(fontSize: 32).center,
      body: buildAnimation().center,
    ); // Splash here
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        splashInit(context);
            // .then((_) => userLogged
            // ? context.router.replaceAll([DashboardRoute()])
            // : context.router.replaceAll([const LoginRoute()]));
      }
    });
  }

  // @override
  // void afterFirstLayout(BuildContext context) {
  //
  // }

  @override
  void didChangeDependencies() {
    // Navigator.of(context);
    super.didChangeDependencies();
  }
}
