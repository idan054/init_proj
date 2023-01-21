// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:example/common/models/post/post_model.dart' as _i15;
import 'package:example/common/models/user/user_model.dart' as _i14;
import 'package:example/screens/auth_ui/a_onboarding_screen.dart' as _i4;
import 'package:example/screens/chat_ui/chat_screen.dart' as _i9;
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart' as _i7;
import 'package:example/screens/chat_ui/members_screen.dart' as _i8;
import 'package:example/screens/feed_ui/create_post_screen.dart' as _i11;
import 'package:example/screens/feed_ui/main_feed_screen.dart' as _i10;
import 'package:example/screens/feed_ui/user_screen.dart' as _i6;
import 'package:example/screens/main_ui/create_user_screen.dart' as _i5;
import 'package:example/screens/main_ui/dashboard_screen.dart' as _i2;
import 'package:example/screens/main_ui/login_screen.dart' as _i3;
import 'package:example/screens/main_ui/splash_screen.dart' as _i1;
import 'package:flutter/material.dart' as _i13;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.DashboardScreen(
          key: args.key,
          dashboardPage: args.dashboardPage,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.OnBoardingScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreateUserRouteOld.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.CreateUserScreenOld(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UserRoute.name: (routeData) {
      final args = routeData.argsAs<UserRouteArgs>();
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.UserScreen(
          args.user,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatsListRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.ChatsListScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MembersRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i8.MembersScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.ChatScreen(
          otherUser: args.otherUser,
          chatId: args.chatId,
          postReply: args.postReply,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainFeedRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i10.MainFeedScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreatePostRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i11.CreatePostScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i12.RouteConfig(
          DashboardRoute.name,
          path: '/dashboard-screen',
        ),
        _i12.RouteConfig(
          LoginRoute.name,
          path: '/login-screen',
        ),
        _i12.RouteConfig(
          OnBoardingRoute.name,
          path: '/on-boarding-screen',
        ),
        _i12.RouteConfig(
          CreateUserRouteOld.name,
          path: '/create-user-screen-old',
        ),
        _i12.RouteConfig(
          UserRoute.name,
          path: '/user-screen',
        ),
        _i12.RouteConfig(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        ),
        _i12.RouteConfig(
          MembersRoute.name,
          path: '/members-screen',
        ),
        _i12.RouteConfig(
          ChatRoute.name,
          path: '/chat-screen',
        ),
        _i12.RouteConfig(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        ),
        _i12.RouteConfig(
          CreatePostRoute.name,
          path: '/create-post-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.DashboardScreen]
class DashboardRoute extends _i12.PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    _i13.Key? key,
    _i2.TabItems dashboardPage = _i2.TabItems.home,
  }) : super(
          DashboardRoute.name,
          path: '/dashboard-screen',
          args: DashboardRouteArgs(
            key: key,
            dashboardPage: dashboardPage,
          ),
        );

  static const String name = 'DashboardRoute';
}

class DashboardRouteArgs {
  const DashboardRouteArgs({
    this.key,
    this.dashboardPage = _i2.TabItems.home,
  });

  final _i13.Key? key;

  final _i2.TabItems dashboardPage;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key, dashboardPage: $dashboardPage}';
  }
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.OnBoardingScreen]
class OnBoardingRoute extends _i12.PageRouteInfo<void> {
  const OnBoardingRoute()
      : super(
          OnBoardingRoute.name,
          path: '/on-boarding-screen',
        );

  static const String name = 'OnBoardingRoute';
}

/// generated route for
/// [_i5.CreateUserScreenOld]
class CreateUserRouteOld extends _i12.PageRouteInfo<void> {
  const CreateUserRouteOld()
      : super(
          CreateUserRouteOld.name,
          path: '/create-user-screen-old',
        );

  static const String name = 'CreateUserRouteOld';
}

/// generated route for
/// [_i6.UserScreen]
class UserRoute extends _i12.PageRouteInfo<UserRouteArgs> {
  UserRoute({
    required _i14.UserModel user,
    _i13.Key? key,
  }) : super(
          UserRoute.name,
          path: '/user-screen',
          args: UserRouteArgs(
            user: user,
            key: key,
          ),
        );

  static const String name = 'UserRoute';
}

class UserRouteArgs {
  const UserRouteArgs({
    required this.user,
    this.key,
  });

  final _i14.UserModel user;

  final _i13.Key? key;

  @override
  String toString() {
    return 'UserRouteArgs{user: $user, key: $key}';
  }
}

/// generated route for
/// [_i7.ChatsListScreen]
class ChatsListRoute extends _i12.PageRouteInfo<void> {
  const ChatsListRoute()
      : super(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        );

  static const String name = 'ChatsListRoute';
}

/// generated route for
/// [_i8.MembersScreen]
class MembersRoute extends _i12.PageRouteInfo<void> {
  const MembersRoute()
      : super(
          MembersRoute.name,
          path: '/members-screen',
        );

  static const String name = 'MembersRoute';
}

/// generated route for
/// [_i9.ChatScreen]
class ChatRoute extends _i12.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required _i14.UserModel otherUser,
    required String chatId,
    _i15.PostModel? postReply,
    _i13.Key? key,
  }) : super(
          ChatRoute.name,
          path: '/chat-screen',
          args: ChatRouteArgs(
            otherUser: otherUser,
            chatId: chatId,
            postReply: postReply,
            key: key,
          ),
        );

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({
    required this.otherUser,
    required this.chatId,
    this.postReply,
    this.key,
  });

  final _i14.UserModel otherUser;

  final String chatId;

  final _i15.PostModel? postReply;

  final _i13.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{otherUser: $otherUser, chatId: $chatId, postReply: $postReply, key: $key}';
  }
}

/// generated route for
/// [_i10.MainFeedScreen]
class MainFeedRoute extends _i12.PageRouteInfo<void> {
  const MainFeedRoute()
      : super(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        );

  static const String name = 'MainFeedRoute';
}

/// generated route for
/// [_i11.CreatePostScreen]
class CreatePostRoute extends _i12.PageRouteInfo<void> {
  const CreatePostRoute()
      : super(
          CreatePostRoute.name,
          path: '/create-post-screen',
        );

  static const String name = 'CreatePostRoute';
}
