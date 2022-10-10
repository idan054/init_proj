import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
// import 'package:example/common/service/Auth/firebase_database.dart';
import 'package:example/widgets/components/postView_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/material.dart';

import '../../common/models/post/post_model.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen()');
    double postRatio = 3;

    return RefreshIndicator(
      backgroundColor: AppColors.darkGrey,
      color: AppColors.primary,
      onRefresh: () async {
            await FeedService.handleGetPost(context);
            setState(()  {});
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        body: Stack(
          children: [
            FutureBuilder<List<PostModel>?>(
                future: FeedService.handleGetPost(context),
                builder: (context, snapshot) {
                  print('START: FutureBuilder()');

                  if (snapshot.hasData == false) {
                    return const CircularProgressIndicator(color: AppColors.primary, strokeWidth: 7)
                        .center;
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return 'Sorry, no post found... \nTry again later!'.toText().center;
                  }
                  var postList = snapshot.data!;
                  var listHeight = 100 * postList.length * postRatio / 2;
                  // var listHeight = 100 * 100.0;
                  return SingleChildScrollView(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: listHeight, //ratio
                          width: context.width * 0.5,
                          child: ListView.builder(
                              itemCount: postList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int i) =>
                                  i.isEven ? const Offstage() : PostView(postList[i])),
                        ).offset(0, 100),
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
