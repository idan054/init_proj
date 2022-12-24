import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';

// import 'package:example/common/service/Auth/firebase_database.dart';
import 'package:example/widgets/components/postViewOld_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../common/models/post/post_model.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/components/postBlock_sts.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  var feedController = PageController();
  var postsController = ScrollController();
  var chipsController = ScrollController();
  List<PostModel> postList = [];
  var splashLoader = true;
  int selectedTag = 0;

  // Todo: Add ranks
  List<String> tags = [
    'New',
    'Gaming',
    'Sport',
    'Music',
    'Netflix',
    'TV',
    'Gaming 2',
    'Sport 2',
    'Music 2',
    'Netflix 2',
    'TV 2',
  ];

  @override
  void initState() {
    print('START: initState()');
    _loadMore();
    super.initState();
  }

  Future _loadMore({bool resetList = false}) async {
    // splashLoader = true; setState(() {});
    if (resetList) postList = [];
    List newPosts = await Database.advanced.handleGetModel(context, ModelTypes.posts, postList);
    if (newPosts.isNotEmpty) postList = [...newPosts];
    splashLoader = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen() ${context.routeData.path}');
    // context.uniProvider.updateIsFeedLoading(false);
    double postRatio = 3;

    return Scaffold(
        backgroundColor: AppColors.darkBlack,
        // backgroundColor: AppColors.darkOutline,
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          backgroundColor: AppColors.darkBg,
          leading: Transform.translate(
            offset: const Offset(5, 0),
            child: CircleAvatar(
              backgroundColor: AppColors.darkGrey,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(context.uniProvider.currUser.photoUrl!),
                backgroundColor: AppColors.darkGrey,
              ),
            ).px(10),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.logoCircularRilTopiaLogo.image(height: 25),
              10.horizontalSpace,
              'RilTopia'.toText(),
            ],
          ),
          actions: [Assets.svg.icons.bellUntitledIcon.svg().px(20).onTap(() {})],
          bottom: PreferredSize(
            preferredSize: const Size(00.0, 50.0),
            child: Card(
              elevation: 0,
              color: AppColors.darkBg,
              child: SizedBox(
                height: 50.0,
                child: ListView(
                  controller: chipsController,
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(
                    tags.length,
                    (int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: ChoiceChip(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: 10.roundedShape,
                          selected: selectedTag == i,
                          backgroundColor: AppColors.darkOutline,
                          selectedColor: AppColors.white,
                          side: BorderSide(width: 2.0, color: AppColors.grey50.withOpacity(0.20)),
                          // side: BorderSide.none,
                          labelStyle: AppStyles.text14PxSemiBold.copyWith(
                              color: selectedTag == i ? AppColors.darkBg : AppColors.white,
                              fontWeight: selectedTag == i ? FontWeight.bold : FontWeight.normal,
                              // fontWeight: FontWeight.bold,
                              fontSize: 12),
                          label: Text(tags[i]),
                          onSelected: (bool selected) {
                            selectedTag = (selected ? i : null)!;
                            feedController.jumpToPage(selectedTag);
                            // feedController.animateToPage(selectedTag!, duration: 250.milliseconds, curve: Curves.easeIn);
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
        body: PageView.builder(
          controller: feedController,
          // dragStartBehavior: DragStartBehavior.down,
          itemCount: tags.length,
          onPageChanged: (index) {
            selectedTag = index;
            setState(() {});
          },
          itemBuilder: (context, index) {
            return ListView(
              children: [
                buildTagTitle(),
                2.verticalSpace,
                Expanded(child: buildFeed(context))
              ],
            );
          },
        ));
  }

  LazyLoadScrollView buildFeed(BuildContext context) {
    return LazyLoadScrollView(
      scrollOffset: 1000,
      onEndOfPage: () async {
        print('START: onEndOfPage()');
        context.uniProvider.updateIsFeedLoading(true);
        await _loadMore();
        context.uniProvider.updateIsFeedLoading(false);
      },
      child: Builder(builder: (context) {
        if (splashLoader) {
          // First time only
          return const CircularProgressIndicator(color: AppColors.primary, strokeWidth: 7).center;
        }

        if (postList.isEmpty) {
          return 'Sorry, no post found... \nTry again later!'.toText().center;
        }

        return RefreshIndicator(
          backgroundColor: AppColors.darkGrey,
          color: AppColors.primary,
          onRefresh: () async {
            print('START: onRefresh()');
            await _loadMore(resetList: true);
          },
          child: ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int i) =>
                // PostView(postList[i])
                PostBlock(postList[i]),
          ),
          // ListView(
          //   physics: const NeverScrollableScrollPhysics(),
          //   children: [
          //     buildTagTitle(),
          //     2.verticalSpace,
          //
          //   ],
          // ),
        );
      }),
    );
  }

  ListTile buildTagTitle() {
    bool isNewTag = tags[selectedTag] == 'New';

    return ListTile(
      minVerticalPadding: 25,
      tileColor: AppColors.darkBg,
      // horizontalTitleGap: 0,
      // leading: Assets.svg.icons.shieldTickUntitledIcon.svg(),
      title: Row(
        children: [
          if (isNewTag) ...[
            Assets.svg.icons.shieldTickUntitledIcon.svg(color: Colors.white70),
            const SizedBox(width: 5),
          ],
          (isNewTag ? 'EXPLORE 14-17 Y.O MEMBERS' : 'MEMBERS WHO INTERESTED IN')
              .toText(fontSize: 13, color: AppColors.grey50)
              .pOnly(top: 3)
        ],
      ).pOnly(bottom: 15),
      subtitle: tags[selectedTag].toUpperCase().toText().appearAll,
    );
  }
}
