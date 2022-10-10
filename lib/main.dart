

import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/screens/main_ui/splash_screen.dart' as click;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'common/models/chat/chat_model.dart';
import 'common/models/message/message_model.dart';
import 'common/models/post/post_model.dart';
import 'common/models/sampleModels.dart';
import 'common/models/universalModel.dart';
import 'common/service/Auth/firebase_options.dart';
import 'common/service/Hive/hive_services.dart';

/// Add More Pre-Actions At [click.SplashScreen]
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final dbDir = await getApplicationDocumentsDirectory();
  Hive.init(dbDir.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(MessageModelAdapter());
  Hive.registerAdapter(ChatModelAdapter());

  await Hive.openBox('uniBox');
  // This before put because i want to get it from cache!!
  print('HiveServices.uniBox.values ${HiveServices.uniBox.values}');
  HiveServices.uniBox.put('user', Sample.user);


  return;
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
    print('BUILD: App.dart');

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
