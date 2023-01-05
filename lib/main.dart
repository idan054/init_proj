
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/screens/main_ui/splash_screen.dart' as click;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'common/models/universalModel.dart';
import 'common/service/Database/firebase_options.dart';
import 'common/themes/app_colors.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

void mainTest() async {
  WidgetsFlutterBinding.ensureInitialized();
  printWhite('START main()!');

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UniProvider()),
          // Provider.value(value: StreamModel().serverClient),
          // FutureProvider<List<Activity>?>.value(
          //     value: StreamModel().getFeedActivities(), initialData: const []),
        ],
        // builder:(context, child) =>
        child: MaterialApp(
          home: MyHomePage(),
        )),
  );
}

class SomeWidget extends StatefulWidget {
  const SomeWidget({Key? key}) : super(key: key);

  @override
  State<SomeWidget> createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<UniProvider>(context, listen: true).postUploaded.toString(),
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<UniProvider>(context, listen: false);

    print('build $this');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            SomeWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newValue = counter.postUploaded = !counter.postUploaded;
          Provider.of<UniProvider>(context, listen: false).updatePostUploaded(newValue);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


/// Add More Pre-Actions At [click.SplashScreen]
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  printWhite('START main()!');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          systemNavigationBarColor: AppColors.primaryDark,
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
      );
    } on Exception catch (e, s) {
      print(s);
      return Center(child: Text('Something went wrong $e'));
    }
  }
}
