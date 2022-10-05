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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:example/common/models/user/user_model.dart' as _i11;
import 'package:example/common/splash_screen.dart' as _i1;
import 'package:example/screens/chat_ui/chat_screen.dart' as _i5;
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart' as _i3;
import 'package:example/screens/chat_ui/members_screen.dart' as _i4;
import 'package:example/screens/feed_ui/create_post_screen.dart' as _i8;
import 'package:example/screens/feed_ui/main_feed_screen.dart' as _i6;
import 'package:example/screens/feed_ui/post_screen.dart' as _i7;
import 'package:example/screens/login_screen.dart' as _i2;
import 'package:flutter/material.dart' as _i10;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatsListRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.ChatsListScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MembersRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.MembersScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i9.CustomPage<dynamic>(
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
    MainFeedRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.MainFeedScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PostRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.PostScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreatePostRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i8.CreatePostScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          LoginRoute.name,
          path: '/login-screen',
        ),
        _i9.RouteConfig(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        ),
        _i9.RouteConfig(
          MembersRoute.name,
          path: '/members-screen',
        ),
        _i9.RouteConfig(
          ChatRoute.name,
          path: '/chat-screen',
        ),
        _i9.RouteConfig(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        ),
        _i9.RouteConfig(
          PostRoute.name,
          path: '/post-screen',
        ),
        _i9.RouteConfig(
          CreatePostRoute.name,
          path: '/create-post-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.ChatsListScreen]
class ChatsListRoute extends _i9.PageRouteInfo<void> {
  const ChatsListRoute()
      : super(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        );

  static const String name = 'ChatsListRoute';
}

/// generated route for
/// [_i4.MembersScreen]
class MembersRoute extends _i9.PageRouteInfo<void> {
  const MembersRoute()
      : super(
          MembersRoute.name,
          path: '/members-screen',
        );

  static const String name = 'MembersRoute';
}

/// generated route for
/// [_i5.ChatScreen]
class ChatRoute extends _i9.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required _i11.UserModel otherUser,
    required String chatId,
    _i10.Key? key,
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

  final _i11.UserModel otherUser;

  final String chatId;

  final _i10.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{otherUser: $otherUser, chatId: $chatId, key: $key}';
  }
}

/// generated route for
/// [_i6.MainFeedScreen]
class MainFeedRoute extends _i9.PageRouteInfo<void> {
  const MainFeedRoute()
      : super(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        );

  static const String name = 'MainFeedRoute';
}

/// generated route for
/// [_i7.PostScreen]
class PostRoute extends _i9.PageRouteInfo<void> {
  const PostRoute()
      : super(
          PostRoute.name,
          path: '/post-screen',
        );

  static const String name = 'PostRoute';
}

/// generated route for
/// [_i8.CreatePostScreen]
class CreatePostRoute extends _i9.PageRouteInfo<void> {
  const CreatePostRoute()
      : super(
          CreatePostRoute.name,
          path: '/create-post-screen',
        );

  static const String name = 'CreatePostRoute';
}
