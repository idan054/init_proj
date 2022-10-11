import 'package:example/common/extensions/extensions.dart';
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
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    // splashLoader = true; setState(() {});
    postList = await FeedService.handleGetPost(context, latest: true) ?? [];
    splashLoader = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen()');
    // context.uniProvider.updateIsFeedLoading(false);
    double postRatio = 3;

    return RefreshIndicator(
      backgroundColor: AppColors.darkGrey,
      color: AppColors.primary,
      onRefresh: () async {
        postList = await FeedService.handleGetPost(context, latest: true) ?? [];
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        body: Stack(
          children: [
            // U might also want to add lazy_load_scrollview Here instead.
            Builder(
                builder: (context) {
                  print('START: FutureBuilder()');

                  if (splashLoader) { // First time only
                    return const CircularProgressIndicator(color: AppColors.primary, strokeWidth: 7)
                        .center;}

                  if (postList.isEmpty) {
                    return 'Sorry, no post found... \nTry again later!'.toText().center;
                  }
                  var listHeight = 100 * postList.length * postRatio / 2;
                  return LazyLoadScrollView(
                    onEndOfPage: () async {
                      print('START: onEndOfPage()');
                      context.uniProvider.updateIsFeedLoading(true);
                      postList = await FeedService.handleGetPost(context, latest: false) ?? [];
                      // await Future.delayed(2.seconds);
                      context.uniProvider.updateIsFeedLoading(false);
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: [
                              'This is the end...'.toText().offset(0, listHeight-100),
                              SizedBox(
                                height: listHeight, //ratio
                                width: context.width * 0.5,
                                child: ListView.builder(
                                    itemCount: postList.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int i) =>
                                        i.isEven ? const Offstage() : PostView(postList[i])),
                              ).offset(0, 100),
                            ],
                          ),
                          Column(
                            children: [
                              'This is the end...'.toText().offset(0, listHeight-100),
                              SizedBox(
                                height: listHeight, //ratio
                                width: context.width * 0.5,
                                child: ListView.builder(
                                    itemCount: postList.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int i) =>
                                        i.isOdd ? const Offstage() : PostView(postList[i])).appearAll,
                              ),
                            ],
                          ),
                        ],
                      )
                    )
                  );
                }),
            Container(
                decoration: const BoxDecoration(
                  color: AppColors.darkBlack,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
                ),
                padding: const EdgeInsets.only(left: 15, right: 17.5, top: 35, bottom: 12.5),
                child: riltopiaLogo(fontSize: 35)),
          ],
        ),
      ),
    );
  }
}
