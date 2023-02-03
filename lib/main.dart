import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Auth/notification_service.dart';
import 'package:example/screens/main_ui/splash_screen.dart' as click;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'common/models/universalModel.dart';
import 'common/service/Database/firebase_options.dart';
import 'common/service/life_cycle.dart';
import 'common/themes/app_colors.dart';

// List<CameraDescription> cameras = <CameraDescription>[];
// Future<void> mainT() async {
//   // Fetch the available cameras before initializing the app.
//   try {
//     WidgetsFlutterBinding.ensureInitialized();
//     cameras = await availableCameras();
//   } on CameraException catch (e) {
//     // _logError(e.code, e.description);
//   }
//   runApp(const MaterialApp(home: CameraExampleHome()));
// }

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Add More Pre-Actions At [click.SplashScreen]
void main() async {
  printWhite('START main()!');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // NotificationService.setupNotifications(_firebaseMessagingBackgroundHandler);
  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  final dbDir = await getApplicationDocumentsDirectory();
  Hive.init(dbDir.path);

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UniProvider()),
          // Provider.value(value: StreamModel().serverClient),
          // FutureProvider<List<Activity>?>.value(
          //     value: StreamModel().getFeedActivities(), initialData: const []),
        ],
        // builder:(context, child) =>

        child: const App()),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final _router = AppRouter(); // Add screens AT app_router.dart

  @override
  Widget build(BuildContext context) {
    print('BUILD: App.dart');

    try {
      return LifeCycleManager(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: AppColors.primaryDark,
            // systemNavigationBarColor: AppColors.darkBg,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            builder: (_, __) => MaterialApp.router(
              routerDelegate: _router.delegate(),
              routeInformationParser: _router.defaultRouteParser(),
              title: 'RilTopia',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorSchemeSeed: AppColors.darkOutline,
                // scaffoldBackgroundColor: AppColors.primaryOriginalColor,
              ),
              builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: Builder(
                    builder: (context) => child!,
                  ),
                );
              },
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
