import 'package:entry/entry.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/app_colors.dart';

var appearDuration = 650;
// var appearDuration = 1550;

extension IconDataX on IconData {
  Icon icon({Color color = AppColors.white, double size = 20}) => Icon(
        this,
        color: color,
        size: size,
      );

  FaIcon iconAwesome({Color color = AppColors.white, double size = 20}) => FaIcon(
        this,
        color: color,
        size: size,
      );
}

extension WidgetX on Widget {
  // My extension:
  Widget onTap(GestureTapCallback? onTap, {double radius = 99, bool onLongPress = false, Color? tapColor}) => Theme(
        data: ThemeData(canvasColor: Colors.transparent),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              overlayColor: tapColor != null ? MaterialStateProperty.all(tapColor) : null,
              //   splashColor: Colors.yellow,
              //   focusColor: Colors.yellow,
              //   highlightColor: Colors.yellow,
              //   hoverColor: Colors.yellow,
              borderRadius: BorderRadius.circular(radius),
              onTap: onLongPress ? null : onTap,
              onLongPress: onLongPress ? onTap : null,
              child: this),
        ),
      );

  Directionality isHebrewDirectionality(String text) => Directionality(
      textDirection: text.isHebrew ? TextDirection.rtl : TextDirection.ltr, child: this);

  Container get testContainer => Container(color: AppColors.testGreen, child: this);

  Directionality get rtl => Directionality(textDirection: TextDirection.rtl, child: this);

  Directionality get ltr => Directionality(textDirection: TextDirection.ltr, child: this);

  ClipRRect get roundedFull => ClipRRect(borderRadius: BorderRadius.circular(999), child: this);

  ClipRRect roundedOnly({
    required double bottomLeft,
    required double topLeft,
    required double topRight,
    required double bottomRight,
  }) =>
      ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeft),
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomRight: Radius.circular(bottomRight),
          ),
          child: this);

  ClipRRect rounded({double? radius}) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius ?? 99), child: this);

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

  Padding pOnly({double top = 0, double right = 0, double bottom = 0, double left = 0, Key? key}) =>
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

  Widget surround(double value) => CircleAvatar(
        backgroundColor: Colors.green,
        child: this,
      );

  Padding pad(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Align get top => Align(
        alignment: Alignment.topCenter,
        child: this,
      );

  Align get bottom => Align(
        alignment: Alignment.bottomCenter,
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

  SizedBox sizedBox(
    double? width,
    double? height,
  ) =>
      SizedBox(
        width: width,
        height: height,
        child: this,
      );

  SizedBox advancedSizedBox(
    context, {
    double? width,
    double? height,
    bool maxWidth = false,
    bool maxHeight = false,
    double wRatio = 1.0,
    double hRatio = 1.0,
  }) {
    double maxHeightSize = MediaQuery.of(context).size.height;
    double maxWidthSize = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width ?? (maxWidth ? maxWidthSize * wRatio : null),
      height: height ?? (maxHeight ? maxHeightSize * hRatio : null),
      child: this,
    );
  }

  Widget offset(double x, double y) => Transform.translate(
        offset: Offset(x, y),
        child: this,
      );

  SliverToBoxAdapter get toSliverBox => SliverToBoxAdapter(child: this);

  Expanded expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  Flexible flexible({required int flex}) => Flexible(
        flex: flex,
        child: this,
      );

  Transform scale({required double scale}) => Transform.scale(
        scale: scale,
        child: this,
      );

  Padding get customRowPadding =>
      Padding(padding: const EdgeInsets.only(top: 15, bottom: 12), child: this);
}
