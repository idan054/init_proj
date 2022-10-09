import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//~ DateTime Convert:
//~ ================
class DateTimeStampConv implements JsonConverter<DateTime, Timestamp> {
  const DateTimeStampConv();

  @override // return DateTime from Timestamp
  DateTime fromJson(Timestamp json) => json.toDate();

  @override // return Timestamp from DateTime
  Timestamp toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}

//~ Color Convert:
//~ ================
class ColorIntConv implements JsonConverter<Color, String> {
  const ColorIntConv();

  @override // return color from String
  Color fromJson(String json) {
    return Color(int.parse(json));
  }

  @override // return String from color
  String toJson(Color color) {
    var colorX = '0x${'$color'.split('0x')[1]}'.replaceAll(')', '');
    return colorX;
  }
}
