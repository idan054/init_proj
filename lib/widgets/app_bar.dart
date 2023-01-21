import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../common/service/mixins/assets.gen.dart';
import '../common/themes/app_colors.dart';
import '../common/themes/app_styles.dart';

AppBar darkAppBar(BuildContext context,
    {required String? title,
    Widget? titleWidget,
    VoidCallback? backAction,
    bool hideBackButton = false,
    bool centerTitle = false,
    List<Widget> actions = const []}) {
  Widget backButton(VoidCallback onPressed) => IconButton(
        onPressed: onPressed,
        icon: Assets.svg.icons.arrowNarrowLeft.svg(color: Colors.white),
      );
  return AppBar(
    elevation: 3,
    titleSpacing: 0.0,
    backgroundColor: AppColors.primaryDark,
    centerTitle: centerTitle,
    title: titleWidget ??
        Text(
          title!,
          style: AppStyles.text18PxRegular.white,
        ),
    leading: hideBackButton
        ? const Offstage()
        : backAction != null
            ? backButton(backAction)
            : backButton(() async => await context.router.pop()),
    actions: actions,
  );
}
