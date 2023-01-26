import 'package:example/common/routes/app_router.gr.dart' as gen;
import 'package:example/screens/auth_ui/a_onboarding_screen.dart';
import 'package:example/screens/auth_ui/b_name_profile_view.dart';
import 'package:example/screens/feed_ui/create_post_screen.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';

import '../../screens/auth_ui/c_gender_age_view.dart';
import '../../screens/auth_ui/d_verify_view.dart';
import '../../screens/auth_ui/e_tags_view_screen.dart';
import '../../screens/chat_ui/chat_screen.dart';
import '../../screens/chat_ui/chats_list_screen.dart.dart';
import '../../screens/chat_ui/members_screen.dart';
import '../../screens/feed_ui/comments_chat_screen.dart';
import '../../screens/user_ui/edit_user_screen.dart';
import '../../screens/user_ui/user_screen.dart';
import '../../screens/main_ui/dashboard_screen.dart';
import '../../screens/auth_ui/login_screen.dart';
import '../../screens/main_ui/splash_screen.dart';
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
    //~ Auth Screens:
    CustomRoute(page: LoginScreen), // Google login
    CustomRoute(page: OnBoardingScreen), // Signup views

    //~ Chat Screens:
    CustomRoute(page: ChatScreen),
    CustomRoute(page: ChatsListScreen),
    CustomRoute(page: MembersScreen),

    //~ Feed Screens:
    CustomRoute(page: MainFeedScreen),
    CustomRoute(page: CreatePostScreen),
    CustomRoute(page: CommentsChatScreen),

    //~ Main Screens:
    CustomRoute(page: SplashScreen, initial: true),
    CustomRoute(page: DashboardScreen),

    //~ User Screens:
    CustomRoute(page: UserScreen),
    CustomRoute(page: EditUserScreen),
    CustomRoute(page: TagsViewScreen),


  ],
)
class $AppRouter {}
