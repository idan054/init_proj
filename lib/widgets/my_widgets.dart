import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/service/mixins/assets.gen.dart';
import '../common/service/mixins/fonts.gen.dart';
import '../common/themes/app_styles.dart';

export 'bottom_sheet.dart';
export 'scaffold_wrapper.dart';

BoxDecoration borderDeco({Color color = Colors.grey, width = 2.0, radius = 10.0}) => BoxDecoration(
      border: Border.all(color: color, width: width),
      borderRadius: BorderRadius.circular(radius),
    );

Widget wMainTextField(
  BuildContext context,
  TextEditingController controller, {
  TextInputType keyboardType = TextInputType.multiline,
  bool autofocus = false,
  Function(String)? onChanged,
  String? topLabel,
  TextStyle? topLabelStyle,
  int? maxLength,
  String? hintText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (topLabel != null)
        Text(topLabel, style: topLabelStyle ?? AppStyles.text16PxBold.white).pOnly(bottom: 5),
      TextField(
        autofocus: autofocus,
        maxLength: maxLength,
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: AppStyles.text20PxBold.white,
        minLines: 1,
        textAlign: TextAlign.center,
        cursorColor: AppColors.primaryOriginal,
        decoration: InputDecoration(
          counter: const Offstage(),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 5),
          filled: true,
          fillColor: AppColors.darkGrey,
          hintText: hintText ?? '',
          hintStyle: AppStyles.text20PxBold.greyLight,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  ).px(55);
}

Widget wMainButton(BuildContext context,
    {required String title,
    bool isWide = true,
    double radius = 12,
    Widget? icon,
    double? width,
    Color color = AppColors.primaryOriginal,
    Color borderColor = AppColors.transparent,
    Color textColor = AppColors.white,
    required VoidCallback? onPressed}) {
  return TextButton.icon(
          style: TextButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: borderColor),
                borderRadius: BorderRadius.circular(radius), // <-- Radius
              )),
          onPressed: onPressed,
          icon: icon ?? const Offstage(),
          label: Text(
            title,
            style: AppStyles.text18PxBold.copyWith(color: textColor),
          ).offset(icon == null ? -5 : 0, 0))
      .advancedSizedBox(context, width: width ?? context.width, height: 55)
      .px(width == null ? (isWide ? 55 : 85) : 0);
}

// New logo
Row riltopiaHorizontalLogo(BuildContext context, {double ratio = 1.0, bool showSubText = false}) {
  var isAdmin = context.uniProvider.currUser.userType == UserTypes.admin;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Assets.images.logoCircularRilTopiaLogo.image(height: 27 * ratio),
      10.horizontalSpace,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isAdmin ? 'RilTopia Admin' : 'RilTopia').toText(fontSize: 15 * ratio),
          // Text(isAdmin ? 'RilTopia Admin' : 'RilTopia', style: TextStyle(fontFamily: FontFamily.rilTopia, fontWeight: FontWeight.w500, fontSize: 18)),
          if (showSubText) ...[
            3.verticalSpace,
            ' A Social Chat App'.toText(fontSize: 7 * ratio),
          ]
        ],
      )
    ],
  );
}

Widget riltopiaLogo({double fontSize = 52, bool shadowActive = true}) {
  TextStyle rilTopiaStyle(Color color) => TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'RilTopia',
        fontWeight: FontWeight.bold,
        shadows: shadowActive
            ? <Shadow>[
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 10.0,
                  color: AppColors.darkBg,
                ),
              ]
            : null,
      );

  return Text.rich(TextSpan(children: <InlineSpan>[
    TextSpan(
      text: 'Ril',
      style: rilTopiaStyle(AppColors.primaryOriginal),
    ),
    TextSpan(
      text: 'Topia',
      style: rilTopiaStyle(AppColors.white),
    ),
  ]));
}
