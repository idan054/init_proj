import 'dart:math';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
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
  List aList = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen()');
    double postRatio = 3;
    var listHeight = 100 * aList.length * postRatio / 2;

    return RefreshIndicator(
      backgroundColor: AppColors.darkGrey,
      color: AppColors.primary,
      onRefresh: () async => setState(() {}),
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        body: Stack(
          children: [
            FutureBuilder<String>(
                future: Future.delayed(2.seconds).then((value) => 'A'),
                builder: (context, snapshot) {
                  if (snapshot.hasData == false) {
                    return const CircularProgressIndicator(
                            color: AppColors.primary, strokeWidth: 7)
                        .center;
                  }
                  return SingleChildScrollView(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: listHeight, //ratio
                          width: context.width * 0.5,
                          child: ListView.builder(
                              itemCount: aList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int i) {
                                if (i.isEven) {
                                  return const Offstage();
                                } else {
                                  var color = Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)];
                                  return Container(
                                    height: 100 * postRatio,
                                    color: color,
                                    child: '${aList[i]}'.testText.center,
                                  ).appearAll;
                                }
                              }),
                        ).offset(0, 100),
                        SizedBox(
                          height: listHeight, //ratio
                          width: context.width * 0.5,
                          child: ListView.builder(
                              itemCount: aList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int i) {
                                if (i.isOdd) {
                                  return const Offstage();
                                } else {
                                  var color = Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)];
                                  var post = PostModel(
                                      textContent: 'Sample text short content',
                                      textAlign: TextAlign.center,
                                      creatorUser: context.uniProvider.currUser,
                                      enableComments: false,
                                      enableLikes: true,
                                      isDarkText: false,
                                      isSubPost: false,
                                      postId: 'Sample${UniqueKey()}',
                                      timestamp: DateTime.now(),
                                      likeCounter: 12,
                                      colorCover: color);
                                  return PostView(post);
                                }
                              }).appearAll,
                        ),
                      ],
                    ),
                  );
                }),
            Container(
                decoration: const BoxDecoration(
                  color: AppColors.darkBlack,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(5)),
                ),
                padding: const EdgeInsets.only(
                    left: 15, right: 17.5, top: 35, bottom: 12.5),
                child: riltopiaLogo(fontSize: 35)),
          ],
        ),
      ),
    );
  }
}
