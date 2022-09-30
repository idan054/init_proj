

import '../../common/splash_page.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/loginScreen.dart';
import 'app_router.dart';

export 'package:auto_route/auto_route.dart';


@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route', // <-----
  routes: [
    // CustomRoute(page: HomePage, path: 'HomePage/:id'),
    CustomRoute(page: SplashPage, initial: true),
    CustomRoute(page: HomeChatsScreen),
    CustomRoute(page: LoginScreen,),

  ],
)
class $AppRouter {}
