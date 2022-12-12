import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';

// import 'package:example/common/service/Auth/firebase_database.dart';
import 'package:example/widgets/components/postView_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../common/models/post/post_model.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  var splashLoader = true;
  List<PostModel> postList = [];

  @override
  void initState() {
    print('START: initState()');
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    // splashLoader = true; setState(() {});
    List newPosts = await Database.advanced.handleGetModel(context, ModelTypes.posts, postList);
    if(newPosts.isNotEmpty) postList = [...newPosts];
    splashLoader = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen()');
    // context.uniProvider.updateIsFeedLoading(false);
    double postRatio = 3;

    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      body: Stack(
        children: [
          LazyLoadScrollView(
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
                return const CircularProgressIndicator(color: AppColors.primary, strokeWidth: 7)
                    .center;
              }

              if (postList.isEmpty) {
                return 'Sorry, no post found... \nTry again later!'.toText().center;
              }
              return RefreshIndicator(
                backgroundColor: AppColors.darkGrey,
                color: AppColors.primary,
                onRefresh: () async {
                  print('START: onRefresh()');
                  await _loadMore();
                },
                child: ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (BuildContext context, int i) => PostView(postList[i])),
              );
            }),
          ),
          Container(
              width: context.width / 2,
              height: 75,
              decoration: const BoxDecoration(
                color: AppColors.darkBlack,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
              ),
              // padding: const EdgeInsets.only(left: 15, right: 17.5, top: 35, bottom: 12.5),
              child: riltopiaLogo(fontSize: 35).center),
        ],
      ),
    );
  }
}
