import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/universalModel.dart';
import '../models/user/user_model.dart';

extension ContextX on BuildContext {
  // Smart navigation shortcuts (Based auto_route)
  // context.router.replace(route) //   pushReplacement
  // context.router.push(route)   //   push

  // My Models
  UniModel get uniModel => Provider.of<UniModel>(this, listen: false);
  UniModel get listenUniModel => Provider.of<UniModel>(this);
  List<UserModel> get listenUserModelList => Provider.of<List<UserModel>>(this);

  //width & height
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  //paddings
  EdgeInsets get padding => MediaQuery.of(this).padding;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  void removeFocus() {
    if (FocusScope.of(this).hasFocus || FocusScope.of(this).hasPrimaryFocus) {
      FocusScope.of(this).unfocus();
    }
  }

  void showSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
