import 'dart:math';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/material.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int postSize = 100;
  List aList = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen()');
    double postRatio = 2.7;
    var listHeight = postSize * aList.length * postRatio / 2;

    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                          var color = Colors.primaries[
                              Random().nextInt(Colors.primaries.length)];
                          return Container(
                            height: postSize * postRatio,
                            color: color,
                            child: '${aList[i]}'.testText.center,
                          );
                        }
                      }),
                ),
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
                          var color = Colors.primaries[
                              Random().nextInt(Colors.primaries.length)];
                          return Container(
                            height: postSize * postRatio,
                            color: color,
                            child: 'לא משנה איפה גדלת,'
                                    ' כי בל שכונה יש אחד שמכניס תצבע לתמונה.'
                                    ' כבר שנים אני מכיר אותו לא השתנה - זה נבסו.'
                                .testText
                                .center,
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                color: AppColors.darkBlack,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(5)),
              ),
              padding: const EdgeInsets.only(
                  left: 15, right: 17.5, top: 35, bottom: 12.5),
              child: riltopiaLogo(fontSize: 31)),
        ],
      ),
    );
  }
}
