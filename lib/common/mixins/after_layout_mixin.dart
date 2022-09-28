import 'package:flutter/material.dart';

mixin AfterLayout<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        afterFirstLayout(context);
      }
    });
  }

  void afterFirstLayout(BuildContext context);
}
