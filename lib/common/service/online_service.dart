import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'Database/firebase_db.dart';
import 'dart:async';
import 'dart:io';

//~ The onlineUsers use SEPARATE doc BECAUSE 'user doc' saves in session cache.

class OnlineService {
  static void setUserOnline(BuildContext context) {
    var currUser = context.uniProvider.currUser;
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

  static void getUsersStatus(BuildContext context) async {
    Timer.periodic(10.seconds, (timer) async {
      print('START: getUsersStatus()');
      var doc = await Database.docData('config/usersStatus');
      print('doc $doc');
      var onlineUsers = doc?['onlineUsers'];
      print('onlineUsers $onlineUsers');
    });
  }
}
