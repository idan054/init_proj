import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:example/common/dump/hive_services.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/fabModel.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/delete_me.dart';
import 'package:example/screens/main_ui/splash_screen.dart' as click;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'common/models/universalModel.dart';
import 'common/routes/app_router.dart';
import 'common/service/Database/firebase_db.dart';
import 'common/service/Database/firebase_options.dart';
import 'common/service/life_cycle.dart';
import 'common/service/Auth/notifications_services.dart';
import 'common/themes/app_colors_inverted.dart';
import 'dart:ui' as ui;
import 'dart:io' show Platform;

Future<void> _handleNotificationReceived(RemoteMessage message) async {
  print("Handling a background message: ${message.toMap()}");
}

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

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', ''), Locale('he', '')],
    path: 'assets/translations',
    child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UniProvider()),
          ChangeNotifierProvider(create: (_) => FabProvider()),
          // Provider.value(value: StreamModel().serverClient),
          // FutureProvider<List<Activity>?>.value(
          //     value: StreamModel().getFeedActivities(), initialData: const []),
        ],
        // builder:(context, child) =>

        child: const App()),
  )
      // child: const MaterialApp(home: ImgbbConverterScreen())),
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final box = await HiveServices.openBoxes();
      final appLang = box.get('App_lang');
      if (appLang == null) setDefaultLocale(box);
    });
    super.initState();
  }

  void setDefaultLocale(Box box) {
    final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
    final hebLocale = systemLocales.firstWhereOrNull((l) =>
        l.languageCode.toUpperCase() == 'HE' ||
        l.languageCode.toUpperCase() == 'IL' ||
        (l.countryCode ?? '').toUpperCase() == 'HE' ||
        (l.countryCode ?? '').toUpperCase() == 'IL');
    print('hebLocale $hebLocale');
    if (hebLocale != null) {
      context.setLocale(const Locale('he', ''));
    } else {
      context.setLocale(const Locale('en', ''));
    }
    box.put('App_lang', hebLocale?.languageCode ?? systemLocales.first.languageCode);
    print('context.locale.toString() ${context.locale.toString()}');
  }

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
              title: 'RilTopia',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(colorSchemeSeed: AppColors.darkOutline),
              // Translation
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              // Routing
              routerDelegate: _router.delegate(navigatorObservers: () => [observer]),
              routeInformationParser: _router.defaultRouteParser(),
              builder: (context, child) {
                return Directionality(
                  textDirection: context.easyTextDirection,
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
