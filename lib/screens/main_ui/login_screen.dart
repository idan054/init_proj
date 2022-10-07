import 'dart:async';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/mixins/assets.gen.dart';
import '../../common/service/Auth/auth_services.dart';
import '../../widgets/my_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    print('START: LoginScreen()');
    if (!kDebugMode) {
      Timer(250.milliseconds, () => AuthService().signInWithGoogle(context));
    }

    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      body: Column(
        children: [
          const Spacer(flex: 4),
          riltopiaLogo(),
          Text(
            'Social Chat App', // STR
            style: AppStyles.text20PxRegular.white,
          ).offset(0, -5),
          35.verticalSpace,
          // googleLoginButton(),
          wMainButton(context,
              radius: 8,
              isWide: false,
              title: 'Google login',
              icon: Assets.svg.gLogoIcon.svg(height: 25),
              color: AppColors.white,
              textColor: AppColors.darkBlack,
              onPressed: () async =>
                  AuthService().signInWithGoogle(context)).appearAll,
          const Spacer(
            flex: 7,
          ),
        ],
      ).center,
    );
  }

/*  Widget googleLoginButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async => AuthService().signInWithGoogle(context),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // decoration: borderDeco(),
            color: AppColors.white,
            child: ListTile(
              visualDensity: VisualDensity.compact,
              leading: Assets.svg.gLogoIcon.svg(height: 25),
              title: Text(
                // loadingText ? 'מיד נכנסים...' :
                'Google login', // STR
                style: AppStyles.text16PxBold.darkBlack,
              ),
              trailing: const Icon(Icons.east).rtl,
            ),
          ),
        ),
      );*/
}
