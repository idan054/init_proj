import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../common/themes/app_colors.dart';
import '../common/themes/app_styles.dart';

AppBar darkAppBar(BuildContext context,
    {required String title,
    PageRouteInfo? leadingReplaceRoute,
    List<Widget> actions = const []}) {
  Widget backButton(VoidCallback backAction) => IconButton(
        onPressed: backAction,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      );
  return AppBar(
    elevation: 0,
    titleSpacing: 0.0,
    backgroundColor: AppColors.darkBlack,
    title: Text(
      title,
      style: AppStyles.text18PxRegular.white,
    ),
    leading: leadingReplaceRoute != null
        ? backButton(
            () async => await context.router.replace(leadingReplaceRoute))
        : backButton(() async => await context.router.pop()),
    actions: actions,
  );
}

// CustomButton(
//         onPressed: () {},
//         title: 'Add',
//         backgroundColor: AppColors.primary)
//     .px(12)
//     .py(8)
