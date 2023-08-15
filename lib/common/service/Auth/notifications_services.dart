import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static final PushNotificationService instance = PushNotificationService();
  static final _fcm = FirebaseMessaging.instance;

  static Future<bool> requestPermission() async {
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
    print('requestPermission() token $token');
    var status = settings.authorizationStatus;
    if (status == AuthorizationStatus.denied) {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  static void setupNotifications(Function(RemoteMessage) onReceived) async {
    print('START: onNotificationReceived()');

    // No Need
    /*
    _fcm.getInitialMessage().then((RemoteMessage? initialMessage) {
      if (initialMessage != null) {
        onReceived(initialMessage);
      }
    });
     */

    //Handle background notifications
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) => onReceived(message));

    //Handle foreground notifications
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) => onReceived(message));

    //Handle notifications when the app is opened
    FirebaseMessaging.onMessage
        .listen((RemoteMessage message) => onReceived(message));
  }

  static void updateFcmToken(BuildContext context, String? fcm) async {
    print('START: updateFcmToken()');
    // var currUser = context.uniProvider.currUser;
    // await Database.updateFirestore(
    //     collection: 'users',
    //     docName: currUser.email.toString(),
    //     toJson: {'fcm': fcm});
    // currUser = currUser.copyWith(fcm: fcm);
    // context.uniProvider.currUserUpdate(currUser);
  }

  //> Actually should be on SERVER!
  static void sendPushNotification({
    required String token,
    required String title,
    required String desc,
    Map<String, String>? payload,
  }) async {
    print('START: sendPushMessage()');

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var headers = {
      'Content-Type': 'application/json',
      //  get auth from: Firebase > Project settings > Cloud Messaging
      'Authorization':
          'key=AAAArxM4tg0:APA91bH6LEe6-8_aVS8w1efVuixaHj7oVN0DI5cGLRDEOryx5wV6mR9gEfPwL8hdG_NMgQ9k3aQCRWnuomSKwcPNnrCW_6KZ1R_QKQoyhadMeOM-A0HA1zYLSTEH1PRYX6h3QKQDg7Fn'
    };

    var body = json.encode({
      "to": token,
      "notification": {
        "title": title,
        "body": desc,
      },
      "sound": "alert.wav", // NOT WORKING RN
      "data": payload,
    });

    var resp = await http.post(url, headers: headers, body: body);
    print('sendPushMessage() resp: ${resp.statusCode}');
    print('sendPushMessage() resp: ${resp.body}');
  }
}
