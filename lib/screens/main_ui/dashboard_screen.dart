// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/main.dart';
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:example/screens/main_ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/models/appConfig/app_config_model.dart';
import '../../common/routes/app_router.gr.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/config/a_get_server_config.dart';
import '../../common/service/config/check_app_update.dart';
import '../../common/service/mixins/assets.gen.dart';
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
    var localConfig = context.uniProvider.localConfig;
    var serverConfig = context.uniProvider.serverConfig;

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        chekForUpdate(context, localConfig, serverConfig!)
    );

    _pageController = PageController(initialPage: widget.dashboardPage.index);
    sItem = widget.dashboardPage;

    super.initState();
  }

  void _handleIndexChanged(int i, bool navBar) {
    sItem = TabItems.values[i];
    // 0 = home, 2 = chat
    //    _pageController.animateToPage(homePage ? 2 : 0, duration: 200.milliseconds, curve: Curves.easeIn);
    // if (sItem.index == 1) return;
    setState(() {});
    if (navBar) {
      _pageController.jumpToPage(i);
    }

    homePage = sItem == TabItems.home;
  }

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');
    _pageController = PageController(initialPage: widget.dashboardPage.index);

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: PageView(
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(), // disable swipe
          onPageChanged: (i) => _handleIndexChanged(i, false),
          children: const <Widget>[
            MainFeedScreen(),
            ChatsListScreen(),
          ]),
      bottomNavigationBar: SizedBox(
        height: 55 + 3,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(color: AppColors.darkOutline, height: 2, width: double.maxFinite),
                SizedBox(
                  height: 55,
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
                        icon: Assets.svg.icons.homeUntitledIcon
                            .svg(color: AppColors.grey50)
                            .pOnly(right: 15),
                        activeIcon: Assets.svg.icons.homeSolidUntitledIcon
                            .svg(color: AppColors.white)
                            .pOnly(right: 15),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: notifyBubble(
                          child: Assets.svg.icons.chatBubblesUntitledIcon
                              .svg(color: AppColors.grey50)
                              .pOnly(left: 15),
                        ),
                        activeIcon: notifyBubble(
                            child:
                            Assets.images.chatBubblesSolid.image(height: 22).pOnly(left: 15)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      // barrierColor: Colors.black54,
                      // barrierColor: Colors.black.withOpacity(0.20), // AKA 20%
                      barrierColor: Colors.black.withOpacity(0.00),
                      // AKA 2%
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return const CreatePostScreen();
                      });
                },
                child: Container(
                    color: AppColors.primaryOriginal,
                    height: 35,
                    width: 35,
                    child: Assets.svg.icons.plusAddUntitledIcon.svg().pad(10))
                    .rounded(radius: 10))
                .center,
          ],
        ),
      ),
    );
  }

  Widget notifyBubble({required Widget child}) {
    // int? counter = context.listenUniProvider.currUser.unreadCounter;

    // return StreamProvider<int?>(
    return StreamBuilder<int?>( //> BETTER Because can handle stream Collection / Doc (!)
      stream: Database.streamUnreadCounter(context),
      initialData: 0,
      builder: (context, snapshot) {
        var counter = context.listenUniProvider.currUser.unreadCounter;
        return counter == null || counter == 0
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