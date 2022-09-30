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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:example/common/splash_page.dart' as _i1;
import 'package:example/screens/home/home_screen.dart' as _i2;
import 'package:example/screens/loginScreen.dart' as _i3;
import 'package:flutter/material.dart' as _i5;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashPage.name: (routeData) {
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeChatsRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeChatsScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          SplashPage.name,
          path: '/',
        ),
        _i4.RouteConfig(
          HomeChatsRoute.name,
          path: '/home-chats-screen',
        ),
        _i4.RouteConfig(
          LoginRoute.name,
          path: '/login-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPage extends _i4.PageRouteInfo<void> {
  const SplashPage()
      : super(
          SplashPage.name,
          path: '/',
        );

  static const String name = 'SplashPage';
}

/// generated route for
/// [_i2.HomeChatsScreen]
class HomeChatsRoute extends _i4.PageRouteInfo<void> {
  const HomeChatsRoute()
      : super(
          HomeChatsRoute.name,
          path: '/home-chats-screen',
        );

  static const String name = 'HomeChatsRoute';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginRoute';
}
