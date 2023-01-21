import 'dart:ui';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/service/mixins/assets.gen.dart';

Future<void> showRilDialog(
  BuildContext context, {
  required String? title,
  required Widget desc,
  bool barrierDismissible = false,
  Widget? secondaryBtn,
  bool showCancelBtn = true,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible, // user must tap button!
    // barrierColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.15),
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AlertDialog(
          backgroundColor: AppColors.primaryDark,
          shape: 15.roundedShape,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                title.toText(fontSize: 16, medium: true),
                16.verticalSpace,
              ],
              desc,
              // 16.verticalSpace,
              // Row(
              //   children: [
              //     Assets.svg.icons.shieldTickUntitledIcon.svg(height: 20, color: Colors.white60),
              //     4.horizontalSpace,
              //     'For a Safe community'.toText(fontSize: 12, color: Colors.white60),
              //   ],
              // ),
            ],
          ),
          actions: <Widget>[
            if (showCancelBtn)
              TextButton(
                  child: 'Cancel'.toText(color: AppColors.primaryLight),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            secondaryBtn ?? const Offstage()
          ],
        ),
      );
    },
  );
}
