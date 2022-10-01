import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../common/themes/app_styles.dart';

AppBar classicAppBar(BuildContext context,
        {required String title,
        PageRouteInfo? leadingReplaceRoute,
        List<Widget> actions = const []}) =>
    AppBar(
      elevation: 3,
      titleSpacing: 0.0,
      backgroundColor: Colors.grey[800],
      title: Text(
        title,
        style: AppStyles.text14PxBold.white,
      ),
      leading: leadingReplaceRoute != null
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => context.router.replace(leadingReplaceRoute))
          : null,
      actions: actions,
    );

// CustomButton(
//         onPressed: () {},
//         title: 'Add',
//         backgroundColor: AppColors.primary)
//     .px(12)
//     .py(8)
