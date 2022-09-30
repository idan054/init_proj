

import '../../common/splash_page.dart';
import '../../screens/home/home_page.dart';
import '../../screens/loginScreen.dart';
import 'app_router.dart';

export 'package:auto_route/auto_route.dart';


@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    CustomRoute(page: SplashPage, initial: true),
    // CustomRoute(page: HomePage, path: 'HomePage/:id'),
    CustomRoute(page: HomePage),
    CustomRoute(page: LoginScreen),

  ],
)
class $AppRouter {}
