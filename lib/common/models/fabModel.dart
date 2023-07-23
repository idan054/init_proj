import 'package:flutter/material.dart';

class FabProvider with ChangeNotifier {
  bool showFab = true;

  void showFabUpdate(bool data) {
    if (showFab == data) return;

    showFab = data;
    notifyListeners();
  }
}