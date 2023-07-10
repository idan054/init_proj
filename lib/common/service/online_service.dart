import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'Database/firebase_db.dart';
import 'dart:async';
import 'dart:io';

class OnlineService {
  static void setUserOnlineStatus(BuildContext context, {required bool isOnline}) {
    print('START: setUserOnline()');
    var currUser = context.uniProvider.currUser;
    var updatedUser = currUser.copyWith(isOnline: isOnline);
    context.uniProvider.currUserUpdate(updatedUser);
    Database.updateFirestore(
        collection: 'users',
        docName: '${updatedUser.email}',
        toJson: updatedUser.toJson());
  }
}
