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

  Future _loadMore({bool resetList = false}) async {
    // splashLoader = true; setState(() {});
    if(resetList) postList = [];
    List newPosts = await Database.advanced.handleGetModel(context, ModelTypes.posts, postList);
    if (newPosts.isNotEmpty) postList = [...newPosts];
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
      appBar: AppBar(actions: [
        CircleAvatar(
          radius: 23,
          backgroundColor: AppColors.darkGrey,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(context.uniProvider.currUser.photoUrl!),
            backgroundColor: AppColors.darkGrey,
          ),
        ).px(10)
      ], title: riltopiaLogo(fontSize: 25), backgroundColor: AppColors.darkBlack),
      body: LazyLoadScrollView(
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
                itemCount: postList.length,
                itemBuilder: (BuildContext context, int i) => PostView(postList[i])),
          );
        }),
      ),
    );
  }
}
