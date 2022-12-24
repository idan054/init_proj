import 'dart:async';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/service/Auth/auth_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../widgets/my_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: LoginScreen()');
    if (!kDebugMode) {
      Timer(250.milliseconds, () => AuthService.signInWithGoogle(context));
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5],
          colors: [
            AppColors.primaryOriginal,
            AppColors.darkBg,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Column(
          children: [
            150.verticalSpace,
            riltopiaLogo(),
            Text(
              'A Social Chat App', // STR
              textAlign: TextAlign.center,
              style: AppStyles.text20PxRegular.copyWith(
                  color: AppColors.white, fontFamily: FontFamily.rilTopia),
            ),
            250.verticalSpace,
            // googleLoginButton(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Share & Chat', // STR
                  textAlign: TextAlign.center,
                  style: AppStyles.text20PxRegular.copyWith(
                      color: AppColors.white, fontFamily: FontFamily.rilTopia),
                ).px(55),
                10.verticalSpace,
                wMainButton(context,
                    radius: 8,
                    isWide: true,
                    title: 'join with Google',
                    icon: Assets.svg.gLogoIcon.svg(height: 25),
                    color: AppColors.white,
                    textColor: AppColors.darkBg,
                    onPressed: () async =>
                       await AuthService.signInWithGoogle(context)).appearAll,
              ],
            ),
            const Spacer(
              flex: 7,
            ),
          ],
        ).center,
      ),
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
