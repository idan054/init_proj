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
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:example/common/models/user/user_model.dart' as _i13;
import 'package:example/screens/chat_ui/chat_screen.dart' as _i8;
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart' as _i6;
import 'package:example/screens/chat_ui/members_screen.dart' as _i7;
import 'package:example/screens/feed_ui/create_post_screen.dart' as _i10;
import 'package:example/screens/feed_ui/main_feed_screen.dart' as _i9;
import 'package:example/screens/feed_ui/user_screen.dart' as _i5;
import 'package:example/screens/main_ui/create_user_screen.dart' as _i4;
import 'package:example/screens/main_ui/dashboard_screen.dart' as _i2;
import 'package:example/screens/main_ui/login_screen.dart' as _i3;
import 'package:example/screens/main_ui/splash_screen.dart' as _i1;
import 'package:flutter/material.dart' as _i12;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreateUserRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.CreateUserScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UserRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.UserScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatsListRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.ChatsListScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MembersRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.MembersScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.ChatScreen(
          otherUser: args.otherUser,
          chatId: args.chatId,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainFeedRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i9.MainFeedScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreatePostRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i10.CreatePostScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i11.RouteConfig(
          DashboardRoute.name,
          path: '/dashboard-screen',
        ),
        _i11.RouteConfig(
          LoginRoute.name,
          path: '/login-screen',
        ),
        _i11.RouteConfig(
          CreateUserRoute.name,
          path: '/create-user-screen',
        ),
        _i11.RouteConfig(
          UserRoute.name,
          path: '/user-screen',
        ),
        _i11.RouteConfig(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        ),
        _i11.RouteConfig(
          MembersRoute.name,
          path: '/members-screen',
        ),
        _i11.RouteConfig(
          ChatRoute.name,
          path: '/chat-screen',
        ),
        _i11.RouteConfig(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        ),
        _i11.RouteConfig(
          CreatePostRoute.name,
          path: '/create-post-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.DashboardScreen]
class DashboardRoute extends _i11.PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    _i12.Key? key,
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

  final _i12.Key? key;

  final _i2.TabItems dashboardPage;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key, dashboardPage: $dashboardPage}';
  }
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.CreateUserScreen]
class CreateUserRoute extends _i11.PageRouteInfo<void> {
  const CreateUserRoute()
      : super(
          CreateUserRoute.name,
          path: '/create-user-screen',
        );

  static const String name = 'CreateUserRoute';
}

/// generated route for
/// [_i5.UserScreen]
class UserRoute extends _i11.PageRouteInfo<void> {
  const UserRoute()
      : super(
          UserRoute.name,
          path: '/user-screen',
        );

  static const String name = 'UserRoute';
}

/// generated route for
/// [_i6.ChatsListScreen]
class ChatsListRoute extends _i11.PageRouteInfo<void> {
  const ChatsListRoute()
      : super(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        );

  static const String name = 'ChatsListRoute';
}

/// generated route for
/// [_i7.MembersScreen]
class MembersRoute extends _i11.PageRouteInfo<void> {
  const MembersRoute()
      : super(
          MembersRoute.name,
          path: '/members-screen',
        );

  static const String name = 'MembersRoute';
}

/// generated route for
/// [_i8.ChatScreen]
class ChatRoute extends _i11.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required _i13.UserModel otherUser,
    required String chatId,
    _i12.Key? key,
  }) : super(
          ChatRoute.name,
          path: '/chat-screen',
          args: ChatRouteArgs(
            otherUser: otherUser,
            chatId: chatId,
            key: key,
          ),
        );

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({
    required this.otherUser,
    required this.chatId,
    this.key,
  });

  final _i13.UserModel otherUser;

  final String chatId;

  final _i12.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{otherUser: $otherUser, chatId: $chatId, key: $key}';
  }
}

/// generated route for
/// [_i9.MainFeedScreen]
class MainFeedRoute extends _i11.PageRouteInfo<void> {
  const MainFeedRoute()
      : super(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        );

  static const String name = 'MainFeedRoute';
}

/// generated route for
/// [_i10.CreatePostScreen]
class CreatePostRoute extends _i11.PageRouteInfo<void> {
  const CreatePostRoute()
      : super(
          CreatePostRoute.name,
          path: '/create-post-screen',
        );

  static const String name = 'CreatePostRoute';
}
