import 'package:entry/entry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

var appearDuration = kDebugMode ? 750 : 250;

extension IconDataX on IconData {
  Icon icon({Color color = AppColors.white, double size = 20}) => Icon(
        this,
        color: color,
        size: size,
      );
}

extension WidgetX on Widget {
  // My extension:
  Container get testContainer => Container(color: Colors.green, child: this);

  Directionality get rtl =>
      Directionality(textDirection: TextDirection.rtl, child: this);

  Directionality get ltr =>
      Directionality(textDirection: TextDirection.ltr, child: this);

  Entry get appearAll => Entry.all(
        duration: Duration(milliseconds: appearDuration),
        child: this,
      );

  Entry get appearScale => Entry.scale(
        duration: Duration(milliseconds: appearDuration),
        child: this,
      );

  Entry get appearOffset => Entry.offset(
        duration: Duration(milliseconds: appearDuration),
        child: this,
      );

  Entry get appearOpacity => Entry.opacity(
        duration: Duration(milliseconds: appearDuration),
        child: this,
      );

  // rest extension:
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

  SizedBox sizedBox(double w, double h) => SizedBox(
        width: w,
        height: h,
        child: this,
      );

  Widget offset(double x, double y) => Transform.translate(
        offset: Offset(x, y),
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
