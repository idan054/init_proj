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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print('START: LoginScreen()');
    // if (!kDebugMode) {
    //   Timer(250.milliseconds, () => AuthService.signInWithGoogle(context));
    // }

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Column(
        children: [
          const Spacer(flex: 25),
          riltopiaHorizontalLogo(ratio: 2.2, showSubText: true),
          30.verticalSpace,
          // const Spacer(flex: 80),
          const Placeholder(fallbackHeight: 450),
          // googleLoginButton(),
          30.verticalSpace,
          wMainButton(context,
              radius: 99,
              isWide: true,
              title: isLoading ? 'Loading...' : 'Join with Google',
              icon: Assets.svg.gLogoIcon.svg(height: 25),
              color: AppColors.white,
              textColor: AppColors.darkBg, onPressed: () async {
            isLoading = true;
            setState(() {});
            await AuthService.signInWithGoogle(context, signUpScenario: true);
            isLoading = false;
            setState(() {});
          }).appearAll,
          const Spacer(flex: 5),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "By Join with Google, you agree to our ",
                    style: AppStyles.text14PxRegular),
                TextSpan(text: '\nTerms & Conditions', style: AppStyles.text14PxBold
                    // .copyWith(decoration: TextDecoration.underline)
                    ),
              ],
            ),
          ).onTap(() {
            // TODO Add Terms & Conditions Link
          }),
          const Spacer(flex: 15),
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
