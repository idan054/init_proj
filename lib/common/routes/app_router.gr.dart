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
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:example/common/models/chat/chat_model.dart' as _i20;
import 'package:example/common/models/post/post_model.dart' as _i19;
import 'package:example/common/models/user/user_model.dart' as _i18;
import 'package:example/screens/auth_ui/a_onboarding_screen.dart' as _i2;
import 'package:example/screens/auth_ui/e_tags_view_screen.dart' as _i15;
import 'package:example/screens/auth_ui/login_screen.dart' as _i1;
import 'package:example/screens/chat_ui/chat_screen.dart' as _i3;
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart' as _i4;
import 'package:example/screens/chat_ui/members_screen.dart' as _i5;
import 'package:example/screens/feed_ui/comments_chat_screen.dart' as _i8;
import 'package:example/screens/feed_ui/create_post_screen.dart' as _i7;
import 'package:example/screens/feed_ui/main_feed_screen.dart' as _i6;
import 'package:example/screens/main_ui/admin_screen.dart' as _i11;
import 'package:example/screens/main_ui/dashboard_screen.dart' as _i10;
import 'package:example/screens/main_ui/notification_screen.dart' as _i12;
import 'package:example/screens/main_ui/splash_screen.dart' as _i9;
import 'package:example/screens/user_ui/edit_user_screen.dart' as _i14;
import 'package:example/screens/user_ui/user_screen.dart' as _i13;
import 'package:flutter/material.dart' as _i17;

class AppRouter extends _i16.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.OnBoardingScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.ChatScreen(
          otherUser: args.otherUser,
          chatId: args.chatId,
          postReply: args.postReply,
          chat: args.chat,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChatsListRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.ChatsListScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MembersRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.MembersScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainFeedRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.MainFeedScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreatePostRoute.name: (routeData) {
      final args = routeData.argsAs<CreatePostRouteArgs>();
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.CreatePostScreen(
          args.replyStyle,
          onChange: args.onChange,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CommentsChatRoute.name: (routeData) {
      final args = routeData.argsAs<CommentsChatRouteArgs>();
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.CommentsChatScreen(
          args.post,
          isFullScreen: args.isFullScreen,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SplashRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i9.SplashScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.DashboardScreen(
          key: args.key,
          dashboardPage: args.dashboardPage,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i11.AdminScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotificationRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i12.NotificationScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UserRoute.name: (routeData) {
      final args = routeData.argsAs<UserRouteArgs>();
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.UserScreen(
          args.user,
          fromEditScreen: args.fromEditScreen,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditUserRoute.name: (routeData) {
      final args = routeData.argsAs<EditUserRouteArgs>();
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i14.EditUserScreen(
          args.user,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TagsViewRoute.name: (routeData) {
      final args = routeData.argsAs<TagsViewRouteArgs>(
          orElse: () => const TagsViewRouteArgs());
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i15.TagsViewScreen(
          user: args.user,
          key: args.key,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(
          LoginRoute.name,
          path: '/login-screen',
        ),
        _i16.RouteConfig(
          OnBoardingRoute.name,
          path: '/on-boarding-screen',
        ),
        _i16.RouteConfig(
          ChatRoute.name,
          path: '/chat-screen',
        ),
        _i16.RouteConfig(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        ),
        _i16.RouteConfig(
          MembersRoute.name,
          path: '/members-screen',
        ),
        _i16.RouteConfig(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        ),
        _i16.RouteConfig(
          CreatePostRoute.name,
          path: '/create-post-screen',
        ),
        _i16.RouteConfig(
          CommentsChatRoute.name,
          path: '/comments-chat-screen',
        ),
        _i16.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i16.RouteConfig(
          DashboardRoute.name,
          path: '/dashboard-screen',
        ),
        _i16.RouteConfig(
          AdminRoute.name,
          path: '/admin-screen',
        ),
        _i16.RouteConfig(
          NotificationRoute.name,
          path: '/notification-screen',
        ),
        _i16.RouteConfig(
          UserRoute.name,
          path: '/user-screen',
        ),
        _i16.RouteConfig(
          EditUserRoute.name,
          path: '/edit-user-screen',
        ),
        _i16.RouteConfig(
          TagsViewRoute.name,
          path: '/tags-view-screen',
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.OnBoardingScreen]
class OnBoardingRoute extends _i16.PageRouteInfo<void> {
  const OnBoardingRoute()
      : super(
          OnBoardingRoute.name,
          path: '/on-boarding-screen',
        );

  static const String name = 'OnBoardingRoute';
}

/// generated route for
/// [_i3.ChatScreen]
class ChatRoute extends _i16.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required _i18.UserModel otherUser,
    required String chatId,
    _i19.PostModel? postReply,
    _i20.ChatModel? chat,
    _i17.Key? key,
  }) : super(
          ChatRoute.name,
          path: '/chat-screen',
          args: ChatRouteArgs(
            otherUser: otherUser,
            chatId: chatId,
            postReply: postReply,
            chat: chat,
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
    this.chat,
    this.key,
  });

  final _i18.UserModel otherUser;

  final String chatId;

  final _i19.PostModel? postReply;

  final _i20.ChatModel? chat;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{otherUser: $otherUser, chatId: $chatId, postReply: $postReply, chat: $chat, key: $key}';
  }
}

/// generated route for
/// [_i4.ChatsListScreen]
class ChatsListRoute extends _i16.PageRouteInfo<void> {
  const ChatsListRoute()
      : super(
          ChatsListRoute.name,
          path: '/chats-list-screen',
        );

  static const String name = 'ChatsListRoute';
}

/// generated route for
/// [_i5.MembersScreen]
class MembersRoute extends _i16.PageRouteInfo<void> {
  const MembersRoute()
      : super(
          MembersRoute.name,
          path: '/members-screen',
        );

  static const String name = 'MembersRoute';
}

/// generated route for
/// [_i6.MainFeedScreen]
class MainFeedRoute extends _i16.PageRouteInfo<void> {
  const MainFeedRoute()
      : super(
          MainFeedRoute.name,
          path: '/main-feed-screen',
        );

  static const String name = 'MainFeedRoute';
}

/// generated route for
/// [_i7.CreatePostScreen]
class CreatePostRoute extends _i16.PageRouteInfo<CreatePostRouteArgs> {
  CreatePostRoute({
    required bool replyStyle,
    required Function onChange,
    _i17.Key? key,
  }) : super(
          CreatePostRoute.name,
          path: '/create-post-screen',
          args: CreatePostRouteArgs(
            replyStyle: replyStyle,
            onChange: onChange,
            key: key,
          ),
        );

  static const String name = 'CreatePostRoute';
}

class CreatePostRouteArgs {
  const CreatePostRouteArgs({
    required this.replyStyle,
    required this.onChange,
    this.key,
  });

  final bool replyStyle;

  final Function onChange;

  final _i17.Key? key;

  @override
  String toString() {
    return 'CreatePostRouteArgs{replyStyle: $replyStyle, onChange: $onChange, key: $key}';
  }
}

/// generated route for
/// [_i8.CommentsChatScreen]
class CommentsChatRoute extends _i16.PageRouteInfo<CommentsChatRouteArgs> {
  CommentsChatRoute({
    required _i19.PostModel post,
    bool isFullScreen = false,
    _i17.Key? key,
  }) : super(
          CommentsChatRoute.name,
          path: '/comments-chat-screen',
          args: CommentsChatRouteArgs(
            post: post,
            isFullScreen: isFullScreen,
            key: key,
          ),
        );

  static const String name = 'CommentsChatRoute';
}

class CommentsChatRouteArgs {
  const CommentsChatRouteArgs({
    required this.post,
    this.isFullScreen = false,
    this.key,
  });

  final _i19.PostModel post;

  final bool isFullScreen;

  final _i17.Key? key;

  @override
  String toString() {
    return 'CommentsChatRouteArgs{post: $post, isFullScreen: $isFullScreen, key: $key}';
  }
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i10.DashboardScreen]
class DashboardRoute extends _i16.PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    _i17.Key? key,
    _i10.TabItems dashboardPage = _i10.TabItems.home,
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
    this.dashboardPage = _i10.TabItems.home,
  });

  final _i17.Key? key;

  final _i10.TabItems dashboardPage;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key, dashboardPage: $dashboardPage}';
  }
}

/// generated route for
/// [_i11.AdminScreen]
class AdminRoute extends _i16.PageRouteInfo<void> {
  const AdminRoute()
      : super(
          AdminRoute.name,
          path: '/admin-screen',
        );

  static const String name = 'AdminRoute';
}

/// generated route for
/// [_i12.NotificationScreen]
class NotificationRoute extends _i16.PageRouteInfo<void> {
  const NotificationRoute()
      : super(
          NotificationRoute.name,
          path: '/notification-screen',
        );

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i13.UserScreen]
class UserRoute extends _i16.PageRouteInfo<UserRouteArgs> {
  UserRoute({
    required _i18.UserModel user,
    bool fromEditScreen = false,
    _i17.Key? key,
  }) : super(
          UserRoute.name,
          path: '/user-screen',
          args: UserRouteArgs(
            user: user,
            fromEditScreen: fromEditScreen,
            key: key,
          ),
        );

  static const String name = 'UserRoute';
}

class UserRouteArgs {
  const UserRouteArgs({
    required this.user,
    this.fromEditScreen = false,
    this.key,
  });

  final _i18.UserModel user;

  final bool fromEditScreen;

  final _i17.Key? key;

  @override
  String toString() {
    return 'UserRouteArgs{user: $user, fromEditScreen: $fromEditScreen, key: $key}';
  }
}

/// generated route for
/// [_i14.EditUserScreen]
class EditUserRoute extends _i16.PageRouteInfo<EditUserRouteArgs> {
  EditUserRoute({
    required _i18.UserModel user,
    _i17.Key? key,
  }) : super(
          EditUserRoute.name,
          path: '/edit-user-screen',
          args: EditUserRouteArgs(
            user: user,
            key: key,
          ),
        );

  static const String name = 'EditUserRoute';
}

class EditUserRouteArgs {
  const EditUserRouteArgs({
    required this.user,
    this.key,
  });

  final _i18.UserModel user;

  final _i17.Key? key;

  @override
  String toString() {
    return 'EditUserRouteArgs{user: $user, key: $key}';
  }
}

/// generated route for
/// [_i15.TagsViewScreen]
class TagsViewRoute extends _i16.PageRouteInfo<TagsViewRouteArgs> {
  TagsViewRoute({
    _i18.UserModel? user,
    _i17.Key? key,
  }) : super(
          TagsViewRoute.name,
          path: '/tags-view-screen',
          args: TagsViewRouteArgs(
            user: user,
            key: key,
          ),
        );

  static const String name = 'TagsViewRoute';
}

class TagsViewRouteArgs {
  const TagsViewRouteArgs({
    this.user,
    this.key,
  });

  final _i18.UserModel? user;

  final _i17.Key? key;

  @override
  String toString() {
    return 'TagsViewRouteArgs{user: $user, key: $key}';
  }
}
