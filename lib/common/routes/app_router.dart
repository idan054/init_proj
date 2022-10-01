import '../../common/splash_screen.dart';
import '../../screens/chat_screen.dart';
import '../../screens/home_chats_screen.dart.dart';
import '../../screens/login_screen.dart';
import '../../screens/members_screen.dart';
import 'app_router.dart';

export 'package:auto_route/auto_route.dart';

// context.router.replace(route) //   pushReplacement
// context.router.push(route)   //   push
@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route', // <-----
  routes: [
    // CustomRoute(page: HomePage, path: 'HomePage/:id'),
    CustomRoute(page: SplashScreen, initial: true),
    CustomRoute(page: HomeChatsScreen),
    CustomRoute(page: LoginScreen),
    CustomRoute(page: MembersScreen),
    CustomRoute(
      page: ChatScreen,
    ),
  ],
)
class $AppRouter {}
