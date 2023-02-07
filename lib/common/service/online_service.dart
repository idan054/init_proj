import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'Database/firebase_db.dart';
import 'dart:async';
import 'dart:io';

//~ The onlineUsers use SEPARATE doc BECAUSE 'user doc' saves in session cache.

class OnlineService {
  static void setUserOnline(BuildContext context) {
    print('START: setUserOnline()');
    var currUser = context.uniProvider.currUser;
    print('currUser.email ${currUser.email}');
    Database.updateFirestore(
      collection: 'config',
      docName: 'usersStatus',
      toJson: {
        'onlineUsers': FieldValue.arrayUnion(['${currUser.email}'])
      },
    );
  }

  static void setUserOffline(BuildContext context) {
    var currUser = context.uniProvider.currUser;
    Database.updateFirestore(
      collection: 'config',
      docName: 'usersStatus',
      toJson: {
        'onlineUsers': FieldValue.arrayRemove(['${currUser.email}'])
      },
    );
  }

  static void updateOnlineUsersStatus(BuildContext context, {bool timerCheck = false}) async {
    print('START: updateOnlineUsersStatus()');
    setUserOnline(context);
    _getOnlineUsersList(context);
    if (timerCheck) {
      Timer.periodic((60 * 5).seconds, (timer) async {
        printYellow('START: 5 MIN SEC PASSED! updateOnlineUsersStatus()');
        _getOnlineUsersList(context);
      });
    }
  }

  static Future<List<String?>?> _getOnlineUsersList(BuildContext context) async {
    var doc = await Database.docData('config/usersStatus');
    context.uniProvider.onlineUsersUpdate(<String>[...doc?['onlineUsers']]);
    var onlineUsersList = context.uniProvider.onlineUsers;
    printYellow('onlineUsersList.length ${onlineUsersList?.length}');
    return onlineUsersList;
  }
}
