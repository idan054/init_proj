import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension StringNullX on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullNotEmpty => this != null && this!.isNotEmpty;
}

extension StringX on String {
  String get sentenceCase => split(' ')
      .map((e) => e.replaceAll('-', ' '))
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(' ');

  bool get isEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool get isPassword => RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
      .hasMatch(this);

  String get firstWordUpper {
    final words = split(' ');
    final buffer = StringBuffer();
    for (var i = 0; i < words.length; i++) {
      if (i == 0) {
        buffer.write(words[i]);
      } else {
        buffer.write('\t');
        buffer.write(words[i][0].toLowerCase() + words[i].substring(1));
      }
    }
    return buffer.toString();
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  DateTime get toDate => DateTime.parse(this).toLocal();

  // My:
  Text toText(
          {Color color = Colors.white,
          double? fontSize,
          TextAlign? textAlign,
          TextStyle? style,
          bool medium = false,
          int maxLines = 2,
          bool bold = false,
          bool underline = false,
          bool softWrap = false}) =>
      // Text(this,
      Text(this,
          softWrap: softWrap,
          maxLines: maxLines,
          textAlign: textAlign ?? (isHebrew ? TextAlign.right : TextAlign.left),
          textDirection: isHebrew ? TextDirection.rtl : TextDirection.ltr,
          overflow: TextOverflow.ellipsis,
          style: style ??
              (bold || (medium && isHebrew)
                  ? AppStyles.text14PxBold.copyWith(
                      color: color,
                      fontSize: fontSize ?? 14.sp,
                      decoration: underline ? TextDecoration.underline : null
                      // height: 1
                      ) // line spacing
                  : medium
                      ? AppStyles.text14PxMedium.copyWith(
                          color: color,
                          fontSize: fontSize ?? 14.sp,
                          decoration:
                              underline ? TextDecoration.underline : null
                          // height: 1
                          )
                      : AppStyles.text14PxRegular.copyWith(
                          color: color,
                          fontSize: fontSize ?? 14.sp,
                          decoration:
                              underline ? TextDecoration.underline : null
                          // height: 1
                          ))); // line spacing

  bool get isHebrew {
    var heb = [
      'א',
      'ב',
      'ג',
      'ד',
      'ה',
      'ו',
      'ז',
      'ח',
      'ט',
      'י',
      'כ',
      'ל',
      'מ',
      'נ',
      'ס',
      'ע',
      'פ',
      'צ',
      'ק',
      'ר',
      'ש',
      'ת',
      'ם',
      'ך',
      'ץ'
    ];

    // if (heb.any((item) => contains(item))) {
    //   // Lists have at least one common element
    //   return true;
    // } else {
    //   // Lists DON'T have any common element
    //   return false;
    // }

    // OLD VERSION
    // ----------
    // actually needs to be map.
    for (var l in heb) {
      if (contains(l)) {
        return true;
      }
    }
    // print('START:  return false;()');
    return false;
  }
}
