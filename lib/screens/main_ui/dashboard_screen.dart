import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/config.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

enum TabItems { chat, home, addButton }

class _DashboardScreenState extends State<DashboardScreen> {
  final _pageController = PageController();
  var sItem = TabItems.home;

  void _handleIndexChanged(int i) {
    sItem = TabItems.values[i];
    _pageController.jumpToPage(i);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');
    bool chatSelected = sItem == TabItems.chat;

    return Scaffold(
      backgroundColor: AppColors.greyDark,
      body: PageView(
        onPageChanged: _handleIndexChanged,
        controller: _pageController,
        children: const [ChatsListScreen(), MainFeedScreen()],
      ),
      extendBody: true, //<------like this
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: AppColors.greyDark,
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        dotIndicatorColor: boldPrimaryDesignConfig
            ? chatSelected
                ? AppColors.white
                : AppColors.primary
            : AppColors.primary,
        marginR: const EdgeInsets.only(right: 110, left: 110, bottom: 20),
        paddingR: sItem == TabItems.chat
            ? const EdgeInsets.symmetric(vertical: 8)
            : EdgeInsets.zero,
        currentIndex: TabItems.values.indexOf(sItem),
        onTap: _handleIndexChanged,
        // dotIndicatorColor: Colors.black,
        items: [
          DotNavigationBarItem(
            icon: FontAwesomeIcons.solidComment.iconAwesome(
                size: 22,
                color: boldPrimaryDesignConfig
                    ? AppColors.white
                    : chatSelected
                        ? AppColors.primary
                        : AppColors.white),
          ),
          if (chatSelected)
            DotNavigationBarItem(
              icon: FontAwesomeIcons.hashtag.iconAwesome(
                  size: 22,
                  color: boldPrimaryDesignConfig
                      ? AppColors.primary
                      : AppColors.white),
              selectedColor: AppColors.primary,
            ),
          if (sItem == TabItems.home)
            DotNavigationBarItem(
              icon: FontAwesomeIcons.circlePlus
                  .iconAwesome(color: AppColors.primary, size: 40),
              selectedColor: AppColors.primary,
            ),
        ],
      ),
    );
  }
}
