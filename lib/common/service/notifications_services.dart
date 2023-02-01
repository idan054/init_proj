import 'dart:convert';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:example/common/extensions/context_extensions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
    var status = settings.authorizationStatus;
    if (status == AuthorizationStatus.denied) {
      AppSettings.openNotificationSettings();
    }
    print('settings.authorizationStatus ${settings.authorizationStatus}');

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  // static void setupNotifications() async {
  //   print('START: _setupNotifications()');
  //   _onNotificationReceived(
  //     onReceived: (RemoteMessage message) {
  //       print('message.toMap() ${message.toMap()}');
  //     },
  //   );
  // }

  static void setupNotifications(Function(RemoteMessage) onReceived) {
    print('START: onNotificationReceived()');
    _fcm.getInitialMessage().then((RemoteMessage? initialMessage) {
      if (initialMessage != null) {
        onReceived(initialMessage);
      }
    });

    //Handle foreground notifications
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) =>  onReceived(message));

    //Handle foreground notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => onReceived(message));

    //Handle notifications when the app is opened
    FirebaseMessaging.onMessage.listen((RemoteMessage message) => onReceived(message));
  }

  static void updateFcmToken(BuildContext context, String? fcm) async {
    var currUser = context.uniProvider.currUser;
    await Database.updateFirestore(
        collection: 'users', docName: currUser.email.toString(), toJson: {'fcm': fcm});
    currUser = currUser.copyWith(fcm: fcm);
    context.uniProvider.updateUser(currUser);
  }

  /// Actually should be on SERVER!
  // https://firebase.google.com/docs/cloud-messaging/concept-options // Examples
  // https://firebase.google.com/docs/cloud-messaging/send-message#rest
  static void sendPushMessage({
    String? token,
    String? notifyBody,
    String? notifyTitle,
    Map<String, String>? payload,
  }) async {
    print('START: sendAwesomePushMessage()');

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var headers = {
      'Content-Type': 'application/json',
      //  get auth from: Firebase > Project settings > Cloud Messaging
      'Authorization':
          'key=AAAArxM4tg0:APA91bH6LEe6-8_aVS8w1efVuixaHj7oVN0DI5cGLRDEOryx5wV6mR9gEfPwL8hdG_NMgQ9k3aQCRWnuomSKwcPNnrCW_6KZ1R_QKQoyhadMeOM-A0HA1zYLSTEH1PRYX6h3QKQDg7Fn'
    };

    // var body = json.encode({
    //   "to": "cRd4mWnARyeBfVlaXmuBxt:APA91bHPlPdm06awpkzavO7Q5hLtUb-Kdqgz2RJH_kkfoqX5lxv2GG_4OVCskvGBDDijl9LwuChm6jClhh-Qd5wELKwYb7fcp9-rB4KeLXqP8h1EQNOgaVCoazvhoqXFtxxN69Xrh1Ld",
    //   // "to": 'YOUR_FCM_TOKEN_HERE', // todo: make while on app notify works!
    //   "mutable_content": true,
    //   "content_available": true,
    //   "priority": "high",
    //   "data": {
    //     "content": {
    //       "id": 100,
    //       "channelKey": "basic_channel",
    //       "title": 'title',
    //       "body": 'body', // notification body
    //       "summary": 'Allergy ALERT',
    //       "notificationLayout": "BigText",
    //       "largeIcon":
    //       "https://play-lh.googleusercontent.com/hMfTz3LRCS8aGPrW61SHkql2XHvSChKyyACJqG1sr4onQN0QWA99OJkgKVVCjB1cNTAf",
    //       // "bigPicture": "https://www.dw.com/image/49519617_303.jpg",
    //       "showWhen": true,
    //       "autoDismissible": true,
    //       "displayOnBackground": true,
    //       "displayOnForeground": true,
    //       // "privacy": "Private",
    //       "payload": payload ?? {}
    //       // "payload": {'K' : 'V'}
    //     },
    //     "actionButtons": [
    //       {"key": "yes", "label": "Yes!", "autoDismissible": true, "isDangerousOption": true},
    //       {"key": "no", "label": "No", "autoDismissible": true}
    //     ]
    //   }
    // });

    var body = json.encode({
      "to":
          "cRd4mWnARyeBfVlaXmuBxt:APA91bHPlPdm06awpkzavO7Q5hLtUb-Kdqgz2RJH_kkfoqX5lxv2GG_4OVCskvGBDDijl9LwuChm6jClhh-Qd5wELKwYb7fcp9-rB4KeLXqP8h1EQNOgaVCoazvhoqXFtxxN69Xrh1Ld",
      "title": "Portugal vs. Denmark",
      "body": "great match!",
      "data": {
        "Nick": "Mario",
        "Room": "PortugalVSDenmark",
      },
      "message": {
        "title": "Portugal vs. Denmark",
        "body": "great match!",
        // "token" :
        "notification": {
          "title": "Portugal vs. Denmark",
          "body": "great match!",
        },
      }
    });

    var resp = await http.post(url, headers: headers, body: body);
    print('resp: ${resp.statusCode}');
    print('resp: ${resp.body}');

  }
}
