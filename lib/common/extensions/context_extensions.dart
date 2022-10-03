import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/universalModel.dart';
import '../models/user/user_model.dart';

extension ContextX on BuildContext {
  // Smart navigation shortcuts (Based auto_route)
  //> context.router.replace(route) //   pushReplacement
  //> context.router.push(route)   //   push

  // My Models
  UniProvider get uniModel => Provider.of<UniProvider>(this, listen: false);
  UniProvider get listenUniModel => Provider.of<UniProvider>(this);
//
  List<UserModel> get userModelList =>
      Provider.of<List<UserModel>>(this, listen: false);
  List<UserModel> get listenUserModelList => Provider.of<List<UserModel>>(this);
//
  List<MessageModel> get messagesModelList =>
      Provider.of<List<MessageModel>>(this, listen: false);
  List<MessageModel> get listenMessagesModelList =>
      Provider.of<List<MessageModel>>(this);
//
  List<ChatModel> get chatsModelList =>
      Provider.of<List<ChatModel>>(this, listen: false);
  List<ChatModel> get listenChatsModelList =>
      Provider.of<List<ChatModel>>(this);

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
