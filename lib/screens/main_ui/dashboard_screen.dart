// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, sort_child_properties_last

import 'dart:async';
import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/main.dart';
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:example/screens/main_ui/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/models/appConfig/app_config_model.dart';
import '../../common/routes/app_router.gr.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/config/a_get_server_config.dart';
import '../../common/service/config/check_app_update.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/notifications_services.dart';
import '../../widgets/my_dialog.dart';
import '../feed_ui/create_post_screen.dart';
import 'dart:io' show Platform;

// enum TabItems { home, placeHolder, chat }
enum TabItems { home, chat }

class DashboardScreen extends StatefulWidget {
  final TabItems dashboardPage;

  const DashboardScreen({Key? key, this.dashboardPage = TabItems.home}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController = PageController();
  TabItems sItem = TabItems.home; // initial
  bool homePage = true;
  var postReadyProgress = 0.0;

  @override
  void initState() {
    NotificationService.instance.requestPermission();

    var localConfig = context.uniProvider.localConfig;
    var serverConfig = context.uniProvider.serverConfig;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => checkForUpdate(context, localConfig, serverConfig!));

    NotificationService.sendPushMessage();

    _pageController = PageController(initialPage: widget.dashboardPage.index);
    sItem = widget.dashboardPage;

    super.initState();
  }

  void _handleIndexChanged(int i, bool navBar) {
    sItem = TabItems.values[i];
    if (sItem == TabItems.home) {
      context.uniProvider.updateFeedType(FeedTypes.members);
      context.uniProvider.updateCurrFilter(FilterTypes.postWithoutComments);
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
    print('START: CreatePostScreen()');
    _pageController = PageController(initialPage: widget.dashboardPage.index);
    var currUser = context.uniProvider.currUser;

    if (currUser.userType == UserTypes.blocked) {
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

    return Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // disable swipe
            // onPageChanged: (i) => _handleIndexChanged(i, false),
            children: const <Widget>[
              MainFeedScreen(),
              ChatsListScreen(),
            ]),
        bottomNavigationBar: SizedBox(
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
                    BottomNavigationBarItem(
                        label: '',
                        icon: Assets.svg.icons.homeUntitledIcon.svg(color: AppColors.grey50),
                        // .pOnly(right: 15),
                        activeIcon:
                            Assets.svg.icons.homeSolidUntitledIcon.svg(color: AppColors.white)
                        // .pOnly(right: 15),
                        ),
                    BottomNavigationBarItem(
                        label: '',
                        icon: notifyBubble(
                            // child: Assets.svg.icons.chatBubblesUntitledIcon.svg(color: AppColors.grey50)
                            child: Assets.svg.icons.groupMultiPeople.svg(color: AppColors.grey50)
                            // .pOnly(left: 15),
                            ),
                        activeIcon: notifyBubble(
                            child: Assets.svg.icons.groupMultiPeopleSolid
                                .svg(color: AppColors.white, height: 19))
                        // .pOnly(left: 15)
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: sItem != TabItems.home ? null : buildFab(),
        floatingActionButton: sItem != TabItems.home ? null : buildFab());
  }

  Builder buildFab() {
    return Builder(builder: (context) {
      var showFab = context.uniProvider.showFab;
      var replyStyle = context.listenUniProvider.feedType == FeedTypes.members;

      SpeedDialChild fabChild(String title, Widget icon, {required bool replyStyle}) {
        return SpeedDialChild(
          child: icon,
          labelWidget: title.toText().px(10),
          labelShadow: [],
          labelBackgroundColor: AppColors.transparent,
          elevation: 5,
          backgroundColor: AppColors.white,
          onTap: () {},
        );
      }

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
                      ? Assets.svg.icons.dmPlaneUntitledIcon.svg(color: AppColors.white)
                      : Assets.svg.icons.messageChatCircleAdd.svg(color: AppColors.white),

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
                        barrierColor: Colors.black38,
                        // barrierColor: Colors.black.withOpacity(0.20), // AKA 20%
                        // barrierColor: Colors.black.withOpacity(0.00),
                        // AKA 2%
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          // print('replyStyle ${replyStyle}');
                          return CreatePostScreen(replyStyle);
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

          // firstChild: FloatingActionButton.extended(
          //   onPressed: () {
          //   },
          //   shape: 6.roundedShape,
          //   label: (replyStyle ? 'New Ril' : 'Add yours').toText(bold: true, fontSize: 13),
          //   icon: replyStyle
          //       ? Assets.images.riltopiaAsIconPNG.image(height: 20).pad(5)
          //       // ? Assets.svg.icons.groupMultiPeople.svg().pad(5)
          //       // : Assets.svg.icons.messageChatCircle.svg(height: 20, color: Colors.white).pad(5),
          //       : Assets.svg.icons.messageChatCircleAdd.svg(height: 20, color: Colors.white).pad(5),
          //   backgroundColor: AppColors.primaryOriginal,
          // ),
        ),
      );
    });
  }

  Widget notifyBubble({required Widget child}) {
    // int? counter = context.listenUniProvider.currUser.unreadCounter;

    // return StreamProvider<int?>(
    return StreamBuilder<int>(
      //> BETTER Because can handle stream Collection / Doc (!)
      // stream: Database.streamUnreadCounter(context),
      stream: Database.streamChatsUnreadCounter(context),
      initialData: 0,
      builder: (context, snapshot) {
        var counter = context.uniProvider.currUser.unreadCounter;
        return counter == 0
            ? child
            : Badge(
                badgeContent: '$counter'.toText(fontSize: 10, color: Colors.white70, medium: true),
                padding: const EdgeInsets.all(5),
                elevation: 0,
                badgeColor: AppColors.errRed,
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
