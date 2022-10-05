import 'package:example/common/routes/app_router.gr.dart' as gen;
import 'package:example/screens/feed_ui/create_post_screen.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';

import '../../screens/chat_ui/chat_screen.dart';
import '../../screens/chat_ui/chats_list_screen.dart.dart';
import '../../screens/chat_ui/members_screen.dart';
import '../../screens/feed_ui/post_screen.dart';
import '../../screens/main_ui/create_user_screen.dart';
import '../../screens/main_ui/login_screen.dart';
import '../../screens/main_ui/splash_screen.dart';
import 'app_router.dart';

export 'package:auto_route/auto_route.dart';

//> context.router.replace(route) //   pushReplacement
//> context.router.push(route)   //   push

/// Full routes available in [gen.AppRouter]
@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route', // <-----
  routes: [
    //~ Main Screens:
    CustomRoute(page: SplashScreen, initial: true),
    CustomRoute(page: LoginScreen),
    CustomRoute(page: CreateUserScreen),
    //~ Chat Screens:
    CustomRoute(page: ChatsListScreen),
    CustomRoute(page: MembersScreen),
    CustomRoute(page: ChatScreen),
    //~ Feed Screens:
    CustomRoute(page: MainFeedScreen),
    CustomRoute(page: PostScreen),
    CustomRoute(page: CreatePostScreen),
  ],
)
class $AppRouter {}
