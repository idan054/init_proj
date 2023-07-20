import 'package:easy_localization/easy_localization.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../models/universalModel.dart';
import '../models/user/user_model.dart';

extension ContextX on BuildContext {
  // Smart navigation shortcuts (Based auto_route)
  //> context.router.replace(route) //   pushReplacement
  //> context.router.push(route)   //   push

  // My Models

  // Use Hot restart while switch between those!
  UniProvider get uniProvider => Provider.of<UniProvider>(this, listen: false);

  UniProvider get listenUniProvider => Provider.of<UniProvider>(this);

  bool get hebLocale => locale.languageCode == 'he';

  ui.TextDirection get easyTextDirection =>
      hebLocale ? ui.TextDirection.rtl : ui.TextDirection.ltr;

  // A Section:
  // context.uniProvider.postUploaded; // current value.
  // context.listenUniProvider.postUploaded; // current value & rebuild when B3 used

  // B Section:
  // context.uniProvider.postUploaded = false; // NOT notify listener
  // context.uniProvider.updatePostUploaded(true, notify: false); // NOT notify listener
  // context.uniProvider.updatePostUploaded(true); // notify listener

//
  List<UserModel> get userModelList => Provider.of<List<UserModel>>(this, listen: false);

  List<UserModel> get listenUserModelList => Provider.of<List<UserModel>>(this);

//
  List<MessageModel> get messagesModelList => Provider.of<List<MessageModel>>(this, listen: false);

  List<MessageModel> get listenMessagesModelList => Provider.of<List<MessageModel>>(this);

//
  List<ChatModel> get chatsModelList => Provider.of<List<ChatModel>>(this, listen: false);

  List<ChatModel> get listenChatsModelList => Provider.of<List<ChatModel>>(this);

  List<PostModel> get commentPostModelList => Provider.of<List<PostModel>>(this, listen: false);

  List<PostModel> get listenCommentPostModelList => Provider.of<List<PostModel>>(this);

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
