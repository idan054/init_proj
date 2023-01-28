import 'dart:io';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/appConfig/app_config_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';
import 'dart:io' show Platform;

// import 'package:example/common/service/Auth/firebase_db.dart';
import 'package:example/common/dump/postViewOld_sts.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import '../../common/extensions/color_printer.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/universalModel.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Auth/auth_services.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/config/check_app_update.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/components/postBlock_sts.dart';
import 'comments_chat_screen.dart';

// region tags
List<String> tags = [
  'Gaming',
  'Art',
  'Sport',
  'Music',
  'Netflix',
  'Study',
  'Work',
  'Tech',
  'Travel',
  'Cars',
  'Nature',
  'Architecture',
  'Paint',
  'Anime',
  'Health',
  'Memes',
  'Food',
  'Animals',
  'News',
  'Politics',
  'Writing',
  'TV',
  'Science',
  'Fashion'
];
// endregion tags

Widget basicLoader() =>
    const CircularProgressIndicator(color: AppColors.primaryLight, strokeWidth: 3).center;

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int tagIndex = 0;
  var splashLoader = true;
  List<PostModel> postList = [];
  var activeFilter = FilterTypes.postWithoutComments;

  // var feedController = PageController();
  // var chipsController = ScrollController();

  @override
  void initState() {
    print('START: initState()');
    _loadMore();
    super.initState();
  }

  Future _loadMore({bool refresh = false}) async {
    print('START: FEED _loadMore()');

    if (refresh) {
      splashLoader = true;
      postList = [];
      setState(() {});
    }

    List newPosts =
        await Database.advanced.handleGetModel(context, ModelTypes.posts, postList, filter: activeFilter);
    if (newPosts.isNotEmpty) postList = [...newPosts];
    splashLoader = false;

    // Temp fix
    setState(() {});
    Future.delayed(350.milliseconds).then((_) => setState(() {}));
    Future.delayed(350.milliseconds).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen() ${context.routeData.path}');
    var postUploaded = context.listenUniProvider.postUploaded;
    if (postUploaded) {
      _loadMore(refresh: true);
      context.uniProvider.postUploaded = false;
      // context.uniProvider.updatePostUploaded(false); // Will rebuild
    }

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: postList.isEmpty ? AppColors.primaryDark : AppColors.darkOutline,
        appBar: _buildRiltopiaAppBar(
          context,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: const BorderSide(width: 2.5, color: AppColors.primaryOriginal),
                insets: 30.horizontal),
            labelStyle: AppStyles.text14PxRegular,
            indicatorColor: AppColors.primaryOriginal,
            tabs: const [
              Tab(text: 'Members'),
              Tab(text: 'Conversions'),
              // Tab(text: 'Latest'),
              // Tab(text: 'Questions'),
            ],
            onTap: (value) async {
              if (value == 0) {
                activeFilter = FilterTypes.postWithoutComments;
              context.uniProvider.updateFeedType(FeedTypes.members);
              }
              if (value == 1) {
                activeFilter = FilterTypes.postWithComments;
              context.uniProvider.updateFeedType(FeedTypes.conversations);
              }
              context.uniProvider.updateCurrFilter(activeFilter);
              await _loadMore(refresh: true);
            },
          ),
        ),
        body: buildFeed(context),
      ),
    );
  }

  Widget buildFeed(BuildContext context) {
    print('START: buildFeed()');

    return LazyLoadScrollView(
      scrollOffset: 1500,
      onEndOfPage: () async {
        printGreen('START: main_feed_screen.dart onEndOfPage()');
        // context.uniProvider.updateIsLoading(true);
        await _loadMore();
        // context.uniProvider.updateIsLoading(false);
      },
      child: Builder(builder: (context) {
        // return 'Sorry, no post found... \nTry again later!'.toText().center;

        if (splashLoader || postList.isEmpty) return basicLoader();

        return RefreshIndicator(
            backgroundColor: AppColors.darkBg,
            color: AppColors.primaryOriginal,
            onRefresh: () async {
              print('START: onRefresh()');
              await _loadMore(refresh: true);
            },
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  context.uniProvider.updateShowFab(false);
                } else if (direction == ScrollDirection.forward) {
                  context.uniProvider.updateShowFab(true);
                }
                // setState(() {});
                return true;
              },
              child: ListView(
                children: [
                  buildTagTitle(),
                  1.verticalSpace,
                  //   Expanded(child:
                  ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: postList.length,
                      itemBuilder: (BuildContext context, int i) {
                        bool isShowAd = i != 0 && (i ~/ 7) == (i / 7); // AKA Every 10 posts.
                        // PostView(postList[i])

                        return Column(
                          children: [
                            //> if (isShowAd) getAd(context),
                            PostBlock(postList[i]),
                          ],
                        );
                      }).appearOpacity,
                  //     )
                ],
              ),
            ));
      }),
    );
  }

  // Widget getAd(BuildContext context) {
  //   BannerAdListener bannerAdListener = BannerAdListener(onAdWillDismissScreen: (ad) {
  //     ad.dispose();
  //   }, onAdClosed: (ad) {
  //     debugPrint("Ad Got Closeed");
  //   });
  //   BannerAd bannerAd = BannerAd(
  //     size: AdSize.banner,
  //     adUnitId: Platform.isAndroid
  //         ? "ca-app-pub-3940256099942544/6300978111"
  //         : "ca-app-pub-3940256099942544/2934735716",
  //     listener: bannerAdListener,
  //     request: const AdRequest(),
  //   );
  //
  //   bannerAd.load();
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       '${context.uniProvider.serverConfig?.adStatus}'
  //           .toText(color: AppColors.grey50, fontSize: 10),
  //       SizedBox(
  //         width: 320,
  //         height: 50,
  //         child: AdWidget(ad: bannerAd),
  //       ),
  //     ],
  //   );
  // }

  ListTile buildTagTitle() {
    // bool isQuestionsTag = newTags[tagIndex] == 'New';
    bool isQuestionsTag = activeFilter == FilterTypes.postWithComments;

    return ListTile(
      minVerticalPadding: 25,
      tileColor: AppColors.primaryDark,
      // horizontalTitleGap: 0,
      // leading: Assets.svg.icons.shieldTickUntitledIcon.svg(),
      title: Row(
        children: [
          isQuestionsTag
              ? Assets.svg.icons.messageChatCircle.svg(color: AppColors.grey50, height: 20)
              : Assets.svg.icons.wisdomLightStar.svg(color: AppColors.grey50, height: 20),
          // : Assets.svg.icons.shieldTickUntitledIcon.svg(color: Colors.white70),
          const SizedBox(width: 7),
          // (isNewTag ? 'EXPLORE 14-17 Y.O MEMBERS' : 'MEMBERS WHO INTERESTED IN')
          // (isQuestionsTag ? 'HELP & SHARE YOUR WISDOM' : 'EXPLORE MEMBERS')
          (isQuestionsTag ? 'JOIN PUBLIC CONVERSATION' : 'EXPLORE MEMBERS')
              .toText(fontSize: 13, color: AppColors.grey50)
              .pOnly(top: 3)
        ],
      ).pOnly(bottom: isQuestionsTag ? 0 : 15),
      // subtitle: newTags[tagIndex].toUpperCase().toText(fontSize: 18, medium: true).appearAll,
      subtitle:
          isQuestionsTag ? null : 'NEW'.toUpperCase().toText(fontSize: 18, medium: true).appearAll,
    );
  }

  AppBar _buildRiltopiaAppBar(BuildContext context, {PreferredSizeWidget? bottom}) {
    var currUser = context.uniProvider.currUser;

    return AppBar(
      elevation: 2,
      backgroundColor: AppColors.primaryDark,
      // backgroundColor: AppColors.darkBg,
      title: riltopiaHorizontalLogo(context, ratio: 1.15)
          .pOnly(bottom: 5, right: 5, left: 5, top: 5)
          .centerLeft,
      // .onTap(() {}, radius: 8),
      actions: [
        //~ Report Screen
        // CircleAvatar(
        //   backgroundColor: AppColors.darkOutline50,
        //     radius: 14,
        //     child: Assets.svg.icons.flag03.svg(color: AppColors.white, height: 15)),

        // child: Icons.flag.icon(color: AppColors.white,)),
        appBarProfile(context),
      ],

      // TODO ADD ON POST MVP ONLY (Notification page)
      // actions: [Assets.svg.icons.bellUntitledIcon.svg().px(20).onTap(() {})],

      bottom: bottom,
      // TODO ADD ON POST MVP ONLY (Tags Row at Main Page)
      // bottom: PreferredSize(
      //   preferredSize: const Size(00.0, 50.0),
      //   child: Card(
      //     elevation: 0,
      //     color: AppColors.primaryDark,
      //     child: _feedChoiceList(context),
      //   ),
      // ),
    );
  }

  SizedBox _feedChoiceList(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView(
        // controller: chipsController,
        scrollDirection: Axis.horizontal,
        children: List<Widget>.generate(
          tags.length,
          (int i) {
            var isChipSelected = tagIndex == i;

            return buildChoiceChip(
              context,
              label: Text(tags[i]),
              selected: isChipSelected,
              onSelect: (bool newSelection) {
                if (newSelection) tagIndex = i;
                context.uniProvider.updateSelectedTag(tags[i]);
                // feedController.jumpToPage(tagIndex);
                // feedController.animateToPage(selectedTag!, duration: 250.milliseconds, curve: Curves.easeIn);
                setState(() {});
              },
            );
          },
        ).toList(),
      ),
    );
  }
}

Widget appBarProfile(BuildContext context) {
  var currUser = context.uniProvider.currUser;

  return CircleAvatar(
    backgroundColor: AppColors.darkOutline,
    radius: 18,
    child: CircleAvatar(
      radius: 16,
      backgroundImage: NetworkImage(context.uniProvider.currUser.photoUrl!),
      backgroundColor: AppColors.darkOutline50,
    ),
  ).px(10).py(5).onTap(() {
    showRilDialog(
      context,
      title: null,
      desc: Column(
        children: [
          //~ Profile
          SizedBox(
            height: 68,
            // height: 72, // 72: original size 60: min size
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              // title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.grey50),
              title: '${currUser.name}'.toText(fontSize: 14, bold: true, color: AppColors.white),
              subtitle: 'SEE YOUR PROFILE'
                  .toText(color: AppColors.grey50, fontSize: 12)
                  .pOnly(right: 10, top: 4, bottom: 10),
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('${currUser.photoUrl}'),
                backgroundColor: AppColors.darkOutline,
              ),
              // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
            ).pad(0).onTap(() {
              print('PROFILE CLICKED');
              Navigator.pop(context);
              context.router.push(UserRoute(user: currUser));
            }, radius: 5),
          ),
          // TODO ADD ON POST MVP ONLY: Add Edit Tags https://prnt.sc/6wXKp7BfpcKx
          const Divider(thickness: 2.5, color: AppColors.darkOutline).py(10),

          //~ Chat with us
          SizedBox(
            height: 50,
            // height: 72, // 72: original size 60: min size
            child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    title:
                        'Chat with us'.toText(fontSize: 14, medium: true, color: AppColors.grey50),
                    leading: Assets.svg.icons.dmPlaneUntitledIcon.svg(color: AppColors.grey50))
                .pad(0)
                .onTap(() {
              Navigator.pop(context);
              ChatService.chatWithUs(context);
            }, radius: 5),
          ),

          //~ Whats New?
          SizedBox(
            height: 50,
            // height: 72, // 72: original size 60: min size
            child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    title: 'Whats new?'.toText(fontSize: 14, medium: true, color: AppColors.grey50),
                    leading: Assets.svg.icons.wisdomLightStar.svg(color: AppColors.grey50))
                .pad(0)
                .onTap(() {
              Navigator.pop(context);
              var localConfig = context.uniProvider.localConfig;
              var serverConfig = context.uniProvider.serverConfig;

              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => checkForUpdate(context, localConfig, serverConfig!, mustShowPopup: true));
            }, radius: 5),
          ),

          //~ Rules
          // SizedBox(
          //   height: 50,
          //   // height: 72, // 72: original size 60: min size
          //   child: ListTile(
          //       contentPadding: EdgeInsets.zero,
          //       horizontalTitleGap: 0,
          //       title: 'Rules'.toText(fontSize: 14, medium: true, color: AppColors.grey50),
          //       leading: Assets.svg.icons.wisdomLightStar.svg(color: AppColors.grey50))
          //       .pad(0)
          //       .onTap(() {
          //     Navigator.pop(context);
          //     var localConfig = context.uniProvider.localConfig;
          //     var serverConfig = context.uniProvider.serverConfig;
          //
          //     WidgetsBinding.instance.addPostFrameCallback(
          //             (_) => chekForUpdate(context, localConfig, serverConfig!, mustShowPopup: true));
          //   }, radius: 5),
          // ),

          //~ Log out
          SizedBox(
            height: 50,
            // height: 72, // 72: original size 60: min size
            child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    title: 'Log out'.toText(fontSize: 14, medium: true, color: AppColors.grey50),
                    leading: Assets.svg.icons.logOut01.svg(color: AppColors.grey50))
                .pad(0)
                .onTap(() async {
              // var isAppleLogin = context.uniProvider.currUser.email!.contains('apple');

              await AuthService.auth.signOut();
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              context.router.replaceAll([const LoginRoute()]);
            }, radius: 5),
          ),
        ],
      ),
      barrierDismissible: true,
      showCancelBtn: false,
    );
    // context.router.push(UserRoute(user: context.uniProvider.currUser));
  });
}

Widget buildChoiceChip(BuildContext context,
    {bool showCloseIcon = false,
    Widget? customIcon,
    Color? selectedColor,
    double? padding,
    bool isUnselectedBorder = true,
    required bool selected,
    ValueChanged<bool>? onSelect,
    required Widget label}) {
  return Padding(
    padding: (padding ?? 6).horizontal,
    child: Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: 7.roundedShape,
          selected: selected,
          materialTapTargetSize: (padding != null) ? MaterialTapTargetSize.shrinkWrap : null,
          padding: (padding != null) ? 0.all : null,
          backgroundColor: AppColors.darkOutline,
          selectedColor: selectedColor ?? AppColors.white,
          side: !isUnselectedBorder
              ? null
              : BorderSide(
                  width: 1.5,
                  color: selectedColor ?? (selected ? AppColors.white : AppColors.grey50)),
          // side: BorderSide.none,
          labelStyle: AppStyles.text14PxRegular.copyWith(
              color: selected ? AppColors.primaryDark : AppColors.white,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              // fontWeight: FontWeight.bold,
              fontSize: 12),
          label: label,
          // disabledColor: selected ? AppColors.primaryDark : AppColors.primaryDark,
          avatar: customIcon ??
              (showCloseIcon && selected
                  ? Assets.svg.icons.iconClose.svg(color: AppColors.primaryDark)
                  : null),
          onSelected: onSelect),
    ),
  );
}
