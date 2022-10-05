import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/screens/main_ui/splash_screen.dart' as click;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'common/models/universalModel.dart';
import 'common/service/Auth/firebase_options.dart';

/// Add More Pre-Actions At [click.SplashScreen]
void main() async {
  // Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  @override
  void initState() {
    super.initState();
  }

  final _router = AppRouter(); // Add screens AT app_router.dart

  @override
  Widget build(BuildContext context) {
    print('Build app.dart');

    try {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          // systemNavigationBarColor: AppColors.whiteColor,
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
            title: 'Example',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                // colorSchemeSeed: AppColors.primaryColor,
                // scaffoldBackgroundColor: AppColors.primaryColor,
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
      );
    } on Exception catch (e, s) {
      print(s);
      return Center(child: Text('Something went wrong $e'));
    }
  }
}
