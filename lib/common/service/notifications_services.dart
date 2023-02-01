import 'dart:io';
import 'package:example/common/extensions/context_extensions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'Database/firebase_db.dart';

class NotificationService {
  static final NotificationService instance = NotificationService();

  static final _fcm = FirebaseMessaging.instance;

  //MARK: - Public
  Future<bool> requestPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    var token = await _fcm.getToken();
    var aPNSToken = await _fcm.getAPNSToken();
    print('token $token');
    print('aPNSToken $aPNSToken');
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  void onNotificationReceived({required Function(RemoteMessage) onReceived}) {
    print('START: onNotificationReceived()');
    //Handle background notifications
    _fcm.getInitialMessage().then((RemoteMessage? initialMessage) {
      if (initialMessage != null) {
        onReceived(initialMessage);
      }
    });

    //Handle foreground notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onReceived(message);
    });

    //Handle notifications when the app is opened
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      onReceived(message);
    });
  }

  static void updateFcmToken(BuildContext context, String? fcm) async {
    var currUser = context.uniProvider.currUser;
    await Database.updateFirestore(
        collection: 'users', docName: currUser.email.toString(), toJson: {'fcm': fcm});
    currUser = currUser.copyWith(fcm: fcm);
    context.uniProvider.updateUser(currUser);
  }
}
