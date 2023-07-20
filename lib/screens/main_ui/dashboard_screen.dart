// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, sort_child_properties_last

import 'dart:async';
import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badge;
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/main.dart';
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:example/screens/main_ui/splash_screen.dart';
import 'package:example/screens/main_ui/widgets/riv_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../common/models/appConfig/app_config_model.dart';
import '../../common/routes/app_router.gr.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/Auth/dynamic_link_services.dart';
import '../../common/service/init/check_app_update.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/Auth/notifications_services.dart';
import '../../common/service/online_service.dart';
import '../../widgets/my_dialog.dart';
import '../feed_ui/create_post_screen.dart';
import 'dart:io' show Platform;
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'notification_screen.dart';

import 'package:camera/camera.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/delete_me.dart';
import 'package:example/screens/main_ui/splash_screen.dart' as click;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

enum TabItems { home, notificationScreen, dmScreen }

class DashboardScreen extends StatefulWidget {
  final TabItems dashboardPage;

  const DashboardScreen({Key? key, this.dashboardPage = TabItems.home}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// class _DashboardScreenState extends State<DashboardScreen> {
class _DashboardScreenState extends State<DashboardScreen>
    with SplashScreenStateMixin, TickerProviderStateMixin {
  PageController _pageController = PageController();
  TabItems sItem = TabItems.home; // initial
  bool homePage = true;
  var postReadyProgress = 0.0;

  @override
  void initState() {
    PushNotificationService.requestPermission();
    updateUserLocationIfNeeded(context);
    DynamicLinkService.initDynamicLinks(context);

    var localConfig = context.uniProvider.localConfig;
    var serverConfig = context.uniProvider.serverConfig;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // BETA TEST:
      FirebaseAnalytics.instance.setCurrentScreen(
        screenName: 'Dashboard',
        screenClassOverride: 'DashboardScreen()',
      );

      checkForUpdate(context, localConfig, serverConfig!);
    });

    // NotificationService.sendPushMessage();

    _pageController = PageController(initialPage: widget.dashboardPage.index);
    sItem = widget.dashboardPage;

    super.initState();
  }

  void _handleIndexChanged(int i, bool navBar) {
    sItem = TabItems.values[i];
    if (sItem == TabItems.home) {
      context.uniProvider.feedTypeUpdate(FeedTypes.rils);
      context.uniProvider.currFilterUpdate(FilterTypes.postWithoutComments);
    }

    // 0 = home, 2 = chat
    //    _pageController.animateToPage(homePage ? 2 : 0, duration: 200.milliseconds, curve: Curves.easeIn);
    // if (sItem.index == 1) return;

    if (mounted) setState(() {});
    if (navBar) {
      _pageController.jumpToPage(i);
    }
    homePage = sItem == TabItems.home;
  }

  @override
  Widget build(BuildContext context) {
    print('START: DashboardScreen()');
    _pageController = PageController(initialPage: widget.dashboardPage.index);
    var currUser = context.uniProvider.currUser;
    var isLoading = context.uniProvider.isLoading;

    if (currUser.userType == UserTypes.blocked) {
      return buildUserBlockedScaffold(context);
    }

    if (currUser.age == null) {
      context.router.push(const LoginRoute());
      return const Offstage();
    }

    return Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: Stack(
          children: [
            PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // disable swipe
                // onPageChanged: (i) => _handleIndexChanged(i, false),
                children: const <Widget>[
                  MainFeedScreen(),
                  NotificationScreen(),
                  ChatsListScreen(),
                ]),
            if (isLoading)
              buildAnimation(
                showText: false,
                ratio: 0.6,
                radius: 20,
              ).center
          ],
        ),
        bottomNavigationBar: Builder(builder: (context) {
          print('START: BUILDER DashboardScreen()');
          // context.listenUniProvider.currUser; // rebuilt when update.

          return SizedBox(
            height: Platform.isAndroid ? 55 + 3 : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(color: AppColors.darkOutline, height: 2, width: double.maxFinite),
                SizedBox(
                  height: Platform.isAndroid ? 55 : null,
                  child: BottomNavigationBar(
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    backgroundColor: AppColors.primaryDark,
                    // backgroundColor: AppColors.darkBg,
                    currentIndex: sItem.index,
                    onTap: (i) {
                      _handleIndexChanged(i, true);
                      // stfSetState(() {});
                    },
                    items: [
                      // HOME
                      BottomNavigationBarItem(
                          label: '',
                          icon: Assets.svg.icons.homeUntitledIcon.svg(color: AppColors.greyLight),
                          activeIcon: Assets.svg.icons.homeSolidUntitledIcon
                              .svg(color: AppColors.greyLight)),

                      // NOTIFICATIONS SCREEN
                      BottomNavigationBarItem(
                          label: '',
                          icon: notificationBadge(
                              child: Assets.svg.icons.bell.svg(color: AppColors.greyLight)),
                          activeIcon: notificationBadge(
                              child: Assets.svg.icons.bellSolid
                                  .svg(height: 23, color: AppColors.greyLight))),

                      // DM SCREEN
                      BottomNavigationBarItem(
                          label: '',
                          icon: unreadChatBadge(
                              child: Assets.svg.icons.groupMultiPeople
                                  .svg(color: AppColors.greyLight)),
                          activeIcon: unreadChatBadge(
                              child: Assets.svg.icons.groupMultiPeopleSolid
                                  .svg(color: AppColors.greyLight, height: 19))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        // floatingActionButton: sItem != TabItems.home ? null : buildFab(),
        floatingActionButton: sItem != TabItems.home ? null : buildFab());
  }

  WillPopScope buildUserBlockedScaffold(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryDark,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              'Your account has been Blocked'.toText(fontSize: 16),
              const SizedBox(height: 10),
              'Please contact us to get details'.toText(color: AppColors.grey50),
              const SizedBox(height: 10),
              TextButton(
                  child: 'Contact support'.toText(color: AppColors.primaryLight),
                  onPressed: () {
                    ChatService.chatWithUs(context);
                  }),
            ],
          ).center,
        ));
  }

  Builder buildFab() {
    return Builder(builder: (context) {
      var showFab = context.uniProvider.showFab;
      var replyStyle = context.listenUniProvider.feedType == FeedTypes.rils;

      // SpeedDialChild fabChild(String title, Widget icon, {required bool replyStyle}) {
      //   return SpeedDialChild(
      //     child: icon,
      //     labelWidget: title.toText().px(10),
      //     labelShadow: [],
      //     labelBackgroundColor: AppColors.transparent,
      //     elevation: 5,
      //     backgroundColor: AppColors.white,
      //     onTap: () {},
      //   );
      // }

      return AnimatedSlide(
        duration: 350.milliseconds,
        offset: showFab ? Offset.zero : const Offset(0, 0),
        child: quickCrossFade(
          showFab,
          duration: 350.milliseconds,
          secondChild: const SizedBox(width: 56, height: 56),
          firstChild: Container(
            height: 56,
            width: 56,
            color: AppColors.primaryOriginal,
            child: Stack(
              children: [
                SizedBox(
                    height: 56,
                    width: 56,
                    child: Assets.images.circleCover.image(fit: BoxFit.fill)),
                SpeedDial(
                  child: replyStyle
                      ? Assets.svg.icons.dmPlaneUntitledIconOutlined
                          .svg(color: AppColors.darkBg, height: 25)
                      // ? Assets.svg.icons.dmPlaneUntitledIconOrginal.svg(color: AppColors.darkBg, height: 25)
                      // : Assets.svg.icons.messageChatCircleAdd.svg(color: AppColors.darkBg),
                      : Assets.images.messageSmileIconPng.image(height: 24),

                  childrenButtonSize: const Size(50, 50),
                  backgroundColor: AppColors.transparent,
                  overlayColor: AppColors.darkBg,
                  overlayOpacity: 0.6,
                  elevation: 0,
                  animationDuration: 250.milliseconds,
                  spacing: 10,
                  onPress: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black26,
                        // barrierColor: Colors.black.withOpacity(0.20), // AKA 20%
                        // barrierColor: Colors.black.withOpacity(0.00),
                        // AKA 2%
                        isScrollControlled: true,
                        context: context,
                        elevation: 0,
                        builder: (context) {
                          // print('replyStyle ${replyStyle}');
                          return CreatePostScreen(
                            replyStyle,
                            onChange: (bool isComments) {
                              print('isComments $isComments');
                              var feedType = isComments ? FeedTypes.talks : FeedTypes.rils;
                              var activeFilter = isComments
                                  ? FilterTypes.postWithComments
                                  : FilterTypes.postWithoutComments;

                              context.uniProvider.currFilterUpdate(activeFilter, notify: false);
                              context.uniProvider.feedTypeUpdate(feedType); // rebuilt listeners
                            },
                          );
                        });
                  },
                  //> TO USE MENU MODE:
                  // children: [
                  //   fabChild(
                  //     replyStyle: true,
                  //     'Ril',
                  //     Assets.svg.icons.dmPlaneUntitledIcon.svg(color: AppColors.primaryOriginal),
                  //   ),
                  //   fabChild(
                  //     replyStyle: false,
                  //     'Conversation',
                  //     Assets.svg.icons.messageChatCircleAdd.svg(color: AppColors.primaryOriginal),
                  //   ),
                  // ]
                ),
              ],
            ),
          ).roundedFull,
        ),
      );
    });
  }

  Widget notificationBadge({required Widget child}) {
    // int? counter = context.listenUniProvider.currUser.unreadCounter;

    // return StreamProvider<int?>(
    return StreamBuilder<int>(
      //> BETTER Because can handle stream Collection / Doc (!)
      // stream: Database.streamUnreadCounter(context),
      stream: Database.streamNotificationCounter(context),
      initialData: 0,
      builder: (context, snapshot) {
        // var counter = context.uniProvider.currUser.unreadNotificationCounter;
        var counter = snapshot.data ?? 0;
        return counter == 0
            ? child
            : badge.Badge(
                badgeContent: '$counter'.toText(fontSize: 10, color: AppColors.white, medium: true),
                padding: const EdgeInsets.all(5),
                elevation: 0,
                badgeColor: AppColors.yellowAlert,
                // stackFit: StackFit.loose,
                // shape:
                child: child);
      },
    );
  }

  Widget unreadChatBadge({required Widget child}) {
    // int? counter = context.listenUniProvider.currUser.unreadCounter;

    // return StreamProvider<int?>(
    return StreamBuilder<int>(
      //> BETTER Because can handle stream Collection / Doc (!)
      // stream: Database.streamUnreadCounter(context),
      stream: Database.streamChatsUnreadCounter(context),
      initialData: 0,
      builder: (context, snapshot) {
        // var counter = context.uniProvider.currUser.unreadCounter;
        var counter = snapshot.data ?? 0;
        return counter == 0
            ? child
            : badge.Badge(
                badgeContent: '$counter'.toText(fontSize: 10, color: AppColors.white, medium: true),
                padding: const EdgeInsets.all(5),
                elevation: 0,
                badgeColor: AppColors.yellowAlert,
                // stackFit: StackFit.loose,
                // shape:
                child: child);
      },
    );
  }

// TO COMPLEX FOR MVP!!
//! DO NOT USE!
// StatefulBuilder buildProgressBar() {
//   print('START: buildProgressBar()');
//
//   StateSetter? _setState;
//
//   // 60 * 5 = 300 (5 min)
//   Timer.periodic(50.milliseconds, (Timer timer) {
//
//     if (postReadyProgress == 1) {
//       timer.cancel();
//     } else {
//       postReadyProgress = postReadyProgress + (0.005);
//     }
//     _setState!(() {});
//   });
//
//   return StatefulBuilder(builder: (context, stfSetState) {
//     _setState = stfSetState;
//
//     return LinearProgressIndicator(
//             color: AppColors.darkBg,
//             backgroundColor: AppColors.primaryDark,
//             value: postReadyProgress)
//         .sizedBox(null, 3);
//   });
// }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
