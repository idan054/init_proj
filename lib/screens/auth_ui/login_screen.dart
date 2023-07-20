import 'dart:async';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/service/Auth/auth_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../widgets/my_widgets.dart';
import 'dart:io' show Platform;

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
          // const Spacer(flex: 20),
          // riltopiaHorizontalLogo(context, ratio: 1.8, showSubText: true),
          // 28.verticalSpace,
          // const Spacer(flex: 80),
          // const Placeholder(fallbackHeight: 450),
          // Assets.images.adPrt1.image().px(15),
          // 4.verticalSpace,
          // Assets.images.adPrt2.image().px(15),

          LayoutBuilder(
              builder: (_, c) => (c.maxWidth > 600)
                  ? Assets.images.onboardingNewBanner
                      .image(fit: BoxFit.cover)
                      .sizedBox(context.width, 850)
                  : Assets.images.onboardingNewBanner.image()),

          // googleLoginButton(),
          const Spacer(flex: 7),

          rilClassicButton(context,
                  radius: 99,
                  isWide: true,
                  title: isLoading ? 'Loading...' : 'Continue with Google',
                  icon: Assets.svg.gLogoIcon.svg(height: 29),
                  bgColor: isLoading ? AppColors.darkOutline50 : AppColors.darkGrey,
                  textColor: isLoading ? AppColors.primaryDark : AppColors.greyLight,
                  onPressed: isLoading
                      ? null
                      : () async {
                          isLoading = true;
                          setState(() {});
                          await AuthService.signInWith(context, autoSignIn: false);
                          isLoading = false;
                          setState(() {});
                        })
              .appearAll,

          if (Platform.isIOS)
            rilClassicButton(context,
                    radius: 99,
                    isWide: true,
                    icon: Assets.svg.apple.svg(height: 23).pOnly(right: 6),
                    title: isLoading ? 'Loading...' : 'Continue with Apple',
                    bgColor: isLoading ? AppColors.darkOutline50 : AppColors.darkGrey,
                    textColor: isLoading ? AppColors.primaryDark : AppColors.greyLight,
                    onPressed: isLoading
                        ? null
                        : () async {
                            isLoading = true;
                            setState(() {});
                            try {
                              await AuthService.signInWith(context,
                                  autoSignIn: false, applePopup: true);
                            } catch (e, s) {
                              // print(s);
                            }
                            isLoading = false;
                            setState(() {});
                          })
                .appearAll
                .pOnly(top: 15),
          const Spacer(flex: 7),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: Platform.isAndroid
                        ? "By 'Continue with Google', you agree to our "
                        : "By 'Continue with Google' or 'Continue with Apple', you agree to our ",
                    style: AppStyles.text14PxRegular.greyLight),
                TextSpan(text: '\nTerms & Conditions', style: AppStyles.text14PxBold.greyLight
                    // .copyWith(decoration: TextDecoration.underline)
                    ),
              ],
            ),
          ).onTap(() {
            launchUrl(
                Uri.parse(
                    'https://www.privacypolicies.com/live/4ae28974-cd40-4c8e-b265-6d6da2c7690b'),
                mode: LaunchMode.externalApplication);
          }, radius: 6),
          const Spacer(flex: 7),
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
