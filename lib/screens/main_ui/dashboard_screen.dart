import 'package:auto_route/auto_route.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/main.dart';
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/config.dart';
import '../../common/routes/app_router.gr.dart';
import '../../common/service/mixins/assets.gen.dart';

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

  @override
  void initState() {
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
      backgroundColor: AppColors.darkBg,
      body: PageView(
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(), // disable swipe
          onPageChanged: (i) => _handleIndexChanged(i, false),
          children: const <Widget>[
            MainFeedScreen(),
            ChatsListScreen(),
          ]),
      bottomNavigationBar: SizedBox(
        height: 55+3,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(color: AppColors.darkBg, height: 3, width: double.maxFinite),
                SizedBox(
                  height: 55,
                  child: BottomNavigationBar(
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    backgroundColor: AppColors.primaryDark,
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
                        icon: Assets.svg.icons.chatBubblesUntitledIcon
                            .svg(color: AppColors.grey50)
                            .pOnly(left: 15),
                        activeIcon: Assets.svg.icons.chatBubblesUntitledIcon
                            .svg(color: AppColors.white)
                            .pOnly(left: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextButton(onPressed: (){}, child:
              Container(
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
}
