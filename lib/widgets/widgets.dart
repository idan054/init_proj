import 'package:flutter/material.dart';
export 'bottom_sheet.dart';
export 'scaffold_wrapper.dart';


BoxDecoration borderDeco(
    {Color color = Colors.grey, width = 2.0, radius = 10.0}) =>
    BoxDecoration(
      border: Border.all(color: color, width: width),
      borderRadius: BorderRadius.circular(radius),
    );