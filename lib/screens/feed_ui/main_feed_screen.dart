import 'dart:math';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/mixins/fonts.gen.dart';
import '../../common/themes/app_styles.dart';

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
    double postRatio = 3;
    var listHeight = postSize * aList.length * postRatio / 2;

    return RefreshIndicator(
      backgroundColor: AppColors.darkGrey,
      color: AppColors.primary,
      onRefresh: () async => setState(() {}),
      child: Scaffold(
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
                            var color = Colors.primaries[
                                Random().nextInt(Colors.primaries.length)];
                            return Stack(
                              children: [
                                Container(
                                  height: postSize * postRatio,
                                  color: color,
                                  child: Text('טוב יאללה עזהו אותי דחוף.\n',
                                          textAlign: TextAlign.center,
                                          style: AppStyles.text18PxBold
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      FontFamily.rilTopia))
                                      .pOnly(right: 5, left: 5)
                                      .center,
                                ),
                                Container(
                                  // color: AppColors.testGreen,
                                  alignment: Alignment.bottomCenter,
                                  height: postSize * postRatio,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.01, 0.25],
                                      colors: [
                                        AppColors.darkBlack.withOpacity(0.40),
                                        AppColors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    minVerticalPadding: 0.0,
                                    contentPadding:
                                        EdgeInsets.only(left: 10, right: 0),
                                    // trailing: Row(
                                    //   children: [
                                    //
                                    //   ],
                                    // ).sizedBox(30, 50).pOnly(right: 5),
                                    leading: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                          '${context.uniProvider.currUser.photoUrl}'),
                                      backgroundColor:
                                          AppColors.darkBlack.withOpacity(0.33),
                                    ).pOnly(right: 5),
                                    title: 'Whatever'.toText(fontSize: 13),
                                    subtitle: Row(
                                      children: [
                                        '15 Min'.toText(
                                            bold: true,
                                            fontSize: 10,
                                            color: AppColors.greyLight),
                                        Spacer(),
                                        '5  '.toText(
                                            bold: true,
                                            fontSize: 10,
                                            color: AppColors.greyLight),
                                        FontAwesomeIcons.heart
                                            .iconAwesome(size: 12)
                                            .offset(0, 2),
                                      ],
                                    ).offset(0, -8).pOnly(right: 10),
                                  ),
                                ).offset(0, 10),
                              ],
                            );
                          }
                        }).appearAll,
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
                child: riltopiaLogo(fontSize: 35)),
          ],
        ),
      ),
    );
  }
}
