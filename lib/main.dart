import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'common/models/universalModel.dart';
import 'common/service/Auth/notifications_services.dart';
import 'common/service/Database/firebase_options.dart';
import 'common/service/life_cycle.dart';

/// Add More Pre-Actions At [click.SplashScreen]
void main() async {
  printWhite('START main()!');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotificationService.setupNotifications(_handleNotificationReceived);
  FirebaseMessaging.onBackgroundMessage(_handleNotificationReceived);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UniProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final _router = AppRouter(); // Add screens AT app_router.dart
  FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  @override
  Widget build(BuildContext context) {
    print('BUILD: App.dart');

    try {
      return LifeCycleManager(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            builder: (_, __) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(colorSchemeSeed: Colors.white),
              routerDelegate:
                  _router.delegate(navigatorObservers: () => [observer]),
              routeInformationParser: _router.defaultRouteParser(),
              builder: (context, child) => Builder(
                builder: (context) => child!,
              ),
            ),
          ),
        ),
      );
    } on Exception catch (e, s) {
      print(s);
      return Center(child: Text('Something went wrong $e'));
    }
  }
}

Future<void> _handleNotificationReceived(RemoteMessage message) async =>
    print("Handling a background message: ${message.toMap()}");
