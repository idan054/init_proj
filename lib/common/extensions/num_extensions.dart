import 'package:flutter/material.dart';
import 'dart:math';

extension NumX on num {
  double get toRadian => (toDouble() * (pi / 180)).toDouble();

  Duration get microseconds => Duration(microseconds: toInt());

  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());

  Duration get minutes => Duration(minutes: toInt());

  Duration get hours => Duration(hours: toInt());

  Duration get days => Duration(days: toInt());

  Future get delayedMicroSeconds async => Future.delayed(toInt().microseconds);

  Future get delayedMilliSeconds async => Future.delayed(toInt().milliseconds);

  Future get delayedSeconds async => Future.delayed(toInt().seconds);

  Future get delayedMinutes async => Future.delayed(toInt().minutes);

  Future get delayedHours async => Future.delayed(toInt().hours);

  Radius get circular => Radius.circular(toDouble());

  BorderRadiusGeometry get rounded => BorderRadius.circular(toDouble());

  RoundedRectangleBorder get roundedShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(toDouble()));

  EdgeInsets get all => EdgeInsets.all(toDouble());

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
}
