import 'package:easy_localization/easy_localization.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/fabModel.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/screens/main_ui/splash_screen.dart' as click;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'common/models/universalModel.dart';
import 'common/service/Auth/notifications_services.dart';
import 'common/service/Database/firebase_options.dart';
import 'common/service/life_cycle.dart';
import 'common/themes/app_colors_inverted.dart';

/// Add More Pre-Actions At [click.SplashScreen]
void main() async {
  printWhite('START main()!');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotificationService.setupNotifications(_handleNotificationReceived);
  FirebaseMessaging.onBackgroundMessage(_handleNotificationReceived);

  final dbDir = await getApplicationDocumentsDirectory();
  Hive.init(dbDir.path);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UniProvider()),
    ChangeNotifierProvider(create: (_) => FabProvider()),
    // Provider.value(value: StreamModel().serverClient),
    // FutureProvider<List<Activity>?>.value(
    //     value: StreamModel().getFeedActivities(), initialData: const []),
  ], child: const App()));
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD: App.dart');

    try {
      return LifeCycleManager(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: AppColors.primaryDark,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            builder: (_, __) => MaterialApp.router(
                title: 'RilTopia',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(colorSchemeSeed: AppColors.darkOutline),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerDelegate: _router.delegate(navigatorObservers: () => [observer]),
                routeInformationParser: _router.defaultRouteParser(),
                builder: (context, child) => Directionality(
                      textDirection: context.autoTextDirection,
                      child: Builder(
                        builder: (context) => child!,
                      ),
                    )),
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
