import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';

cleanSnack(
  BuildContext context, {
  required String text,
  Color? color,
  Color? textColor,
  int sec = 3,
  SnackBarAction? customAction,
  bool showSnackAction = true,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    duration: sec.seconds,
    behavior: SnackBarBehavior.floating,
    backgroundColor: color ?? AppColors.darkGrey,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: textColor ?? AppColors.greyLight,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    ),
    action: showSnackAction
        ? (customAction ??
            SnackBarAction(
              label: 'close',
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ))
        : SnackBarAction(
            label: '',
            onPressed: () {},
          ),
  ));
}
