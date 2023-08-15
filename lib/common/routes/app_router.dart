import 'package:example/common/routes/app_router.gr.dart' as gen;
import 'package:example/screens/splash_screen.dart';
import 'app_router.dart';
export 'package:auto_route/auto_route.dart';

//> HOW TO USE:
// Just create STF & Add CustomRoute() below    //   Add route
// Than: flutter packages pub run build_runner build
// context.router.replace(route)                //   pushReplacement
// context.router.push(route)                   //   push

/// Full routes available in [gen.AppRouter]
@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route', // <-----
  routes: [
    CustomRoute(page: SplashScreen, initial: true),
  ],
)
class $AppRouter {}
