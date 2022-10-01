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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:example/common/models/user/user_model.dart' as _i8;
import 'package:example/common/splash_screen.dart' as _i1;
import 'package:example/screens/chat_screen.dart' as _i5;
import 'package:example/screens/home_chats_screen.dart.dart' as _i2;
import 'package:example/screens/login_screen.dart' as _i3;
import 'package:example/screens/members_screen.dart' as _i4;
import 'package:flutter/material.dart' as _i7;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeChatsRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeChatsScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MembersRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.MembersScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.ChatScreen(
          otherUser: args.otherUser,
          chatId: args.chatId,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          HomeChatsRoute.name,
          path: '/home-chats-screen',
        ),
        _i6.RouteConfig(
          LoginRoute.name,
          path: '/login-screen',
        ),
        _i6.RouteConfig(
          MembersRoute.name,
          path: '/members-screen',
        ),
        _i6.RouteConfig(
          ChatRoute.name,
          path: '/chat-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.HomeChatsScreen]
class HomeChatsRoute extends _i6.PageRouteInfo<void> {
  const HomeChatsRoute()
      : super(
          HomeChatsRoute.name,
          path: '/home-chats-screen',
        );

  static const String name = 'HomeChatsRoute';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.MembersScreen]
class MembersRoute extends _i6.PageRouteInfo<void> {
  const MembersRoute()
      : super(
          MembersRoute.name,
          path: '/members-screen',
        );

  static const String name = 'MembersRoute';
}

/// generated route for
/// [_i5.ChatScreen]
class ChatRoute extends _i6.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required _i8.UserModel otherUser,
    required String chatId,
    _i7.Key? key,
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

  final _i8.UserModel otherUser;

  final String chatId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{otherUser: $otherUser, chatId: $chatId, key: $key}';
  }
}
