import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/themes/app_colors.dart';
import '../common/themes/app_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({Key? key, this.height, required this.title, this.leading})
      : super(key: key);
  final double? height;
  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    var _borderStyle = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.greyLight,
      ),
      borderRadius: BorderRadius.circular(4),
    );

    return SizedBox(
      height: height ?? 30.h,
      child: TextField(
        cursorHeight: 12,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          focusedBorder: _borderStyle.copyWith(
              borderSide: const BorderSide(color: AppColors.primaryOriginal)),
          enabledBorder: _borderStyle,
          border: _borderStyle,
          hintText: title,
          hintStyle: AppStyles.text10PxRegular,
          prefixIcon: leading,
        ),
      ),
    );
  }
}
