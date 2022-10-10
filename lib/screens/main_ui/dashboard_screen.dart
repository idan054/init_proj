import 'package:auto_route/auto_route.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/config.dart';
import '../../common/routes/app_router.gr.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

enum TabItems { chat, home }

class _DashboardScreenState extends State<DashboardScreen> {
  final _pageController = PageController(initialPage: TabItems.home.index);
  var sItem = TabItems.home; // initial

  void _handleIndexChanged(int i) {
    sItem = TabItems.values[i];
    _pageController.animateToPage(i,
        duration: 200.milliseconds, curve: Curves.easeIn);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');
    bool chatSelected = sItem == TabItems.chat;

    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: PageView(
        onPageChanged: _handleIndexChanged,
        controller: _pageController,
        children: const [ChatsListScreen(), MainFeedScreen()],
      ),
      extendBody: true, //<------like this
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: AppColors.darkGrey,
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        dotIndicatorColor:
        context.listenUniProvider.isFeedLoading ? AppColors.transparent :
        boldPrimaryDesignConfig
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
          if (sItem == TabItems.home
              && context.listenUniProvider.isFeedLoading)
            DotNavigationBarItem(
              icon: InkWell(
                onTap: () => context.router.push(const CreatePostRoute()),
                child: const CircularProgressIndicator(
                    color: AppColors.primary, strokeWidth: 6).scale(scale: 0.90).pad(2)
              ),
              selectedColor: AppColors.primary,
            ),
          if (sItem == TabItems.home
              && context.listenUniProvider.isFeedLoading == false)
            DotNavigationBarItem(
              icon: InkWell(
                onTap: () => context.router.push(const CreatePostRoute()),
                child: FontAwesomeIcons.circlePlus
                    .iconAwesome(color: AppColors.primary, size: 40),
              ),
              selectedColor: AppColors.primary,
            ),


        ],
      ),
    );
  }
}
