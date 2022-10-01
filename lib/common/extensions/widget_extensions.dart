import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../common/themes/themes.dart';

extension WidgetX on Widget {

  Container get testContainer => Container(color: Colors.green, child: this);

  Directionality get rtl => Directionality(textDirection: TextDirection.rtl, child: this);
  Directionality get ltr => Directionality(textDirection: TextDirection.ltr, child: this);

  Padding px(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Padding py(double padding, {Key? key}) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        key: key,
        child: this,
      );

  Padding pOnly(
          {double top = 0,
          double right = 0,
          double bottom = 0,
          double left = 0,
          Key? key}) =>
      Padding(
        padding: EdgeInsets.only(
          top: top,
          right: right,
          bottom: bottom,
          left: left,
        ),
        key: key,
        child: this,
      );

  Center get center => Center(child: this);

  Padding pad(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Align get centerLeft => Align(
        alignment: Alignment.centerLeft,
        child: this,
      );

  Align get centerRight => Align(
        alignment: Alignment.centerRight,
        child: this,
      );


  SizedBox sizedBox(w, h) => SizedBox(
        width: w,
        height: h,
        child: this,
      );

  SliverToBoxAdapter get toSliverBox => SliverToBoxAdapter(child: this);

  Expanded expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  Transform scale({required double scale}) => Transform.scale(
        scale: scale,
        child: this,
      );
}

extension TextStyleX on TextStyle {
  //colors

  // TextStyle get darkGrey => copyWith(color: AppColors.darkGreyColor);

  TextStyle get red => copyWith(color: AppColors.redColor);

  TextStyle get primary => copyWith(color: AppColors.primary);

  TextStyle get black => copyWith(color: AppColors.darkBlack);

  TextStyle get darkBlack => copyWith(color: AppColors.black);

  TextStyle get white => copyWith(color: AppColors.white);

  TextStyle get green => copyWith(color: AppColors.green);

  TextStyle get solidGrey => copyWith(color: AppColors.solidGrey);

  TextStyle get grey200Color => copyWith(color: AppColors.grey200);

  TextStyle lineHeight(double value) => copyWith(height: value / fontSize!);

// TextStyle spacing(double value) =>
//     copyWith(letterSpacing: calculateSpacing(value));
}
