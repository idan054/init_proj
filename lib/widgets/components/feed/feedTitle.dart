import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:rive/rive.dart';
import '../../../common/models/report/report_model.dart';
import '../../../common/routes/app_router.gr.dart';
import '../../../common/service/Database/db_advanced.dart';
import '../../../common/service/Database/firebase_db.dart';
import '../../../common/service/mixins/assets.gen.dart';
import '../../../common/themes/app_colors_inverted.dart';
import '../../../screens/feed_ui/main_feed_screen.dart';
import '../../../screens/main_ui/admin_screen.dart';
import '../../../screens/main_ui/notification_screen.dart';
import 'package:flutter/material.dart';

import 'bottom_sort_sheet.dart';

Widget basicLoaderRiltopia() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder(
            duration: 1.seconds,
            tween: Tween<double>(begin: 0, end: 1),
            builder: (BuildContext context, double value, Widget? child) {
              return Stack(
                children: [
                  Container(
                          color: AppColors.primaryOriginal.withOpacity(value),
                          height: 80,
                          width: 80,
                          padding: 5.all,
                          child: RiveAnimation.asset('assets/riv/rilmanblackwhitefaster.riv')
                              .offset(0, 5))
                      .roundedFull,
                  Assets.images.circleCover.image(fit: BoxFit.fill).sizedBox(80, 80),
                ],
              );
            }),
      ],
    );

Widget basicLoader() =>
    const CircularProgressIndicator(color: AppColors.primaryOriginal, strokeWidth: 6).center;

Widget buildFeedSort(
  BuildContext context,
  FeedTypes feedType, {
  required GestureTapCallback onFeedSort,
  required GestureTapCallback onTopicChanged,
}) {
  bool isConversationTab = feedType == FeedTypes.talks;
  bool isNewRilsTab = feedType == FeedTypes.rils;
  final currfilter = context.uniProvider.sortFeedBy;
  final currUser = context.uniProvider.currUser;
  final ageRange = ageRangeList(currUser);
  final ageRangeStr = ' (${ageRange.first} - ${ageRange.last})';
  final title =
      '${currfilter.title.replaceAll('sortFeedBy', '').replaceAll('sortFeedBy', '').tr().replaceAll('רילס ', '').replaceAll('משתמשים ', '')}'
      '${context.hebLocale ? ' ' : ''}';

  return ListTile(
          // minVerticalPadding: 15,
          tileColor: AppColors.primaryDark,
          onTap: onFeedSort,
          // horizontalTitleGap: 0,
          // leading: Assets.svg.icons.shieldTickUntitledIcon.svg(),
          title: Row(
            children: [
              Stack(
                children: [
                  SvgGenImage(currfilter.solidSvg).svg(color: AppColors.yellowAlert, height: 20),
                  if (currfilter.type == FilterTypes.sortFeedByIsOnline)
                    buildUserCircleOnline(true),
                ],
              ),
              const SizedBox(width: 7),
              '${'Sort Rils by'.tr()}'
                  .toText(fontSize: 13, color: AppColors.greyLight)
                  .pOnly(top: 3),
              title
                  // .replaceAll('Your topics', 'Your ${currUser.tags.length} topics')
                  .toText(
                      bold: true,
                      fontSize: 13,
                      color: AppColors.white,
                      underline: currfilter.type == FilterTypes.sortFeedByTopics)
                  .pOnly(top: 3 + 7, bottom: 7, right: 7)
                  .onTap(
                      currfilter.type == FilterTypes.sortFeedByTopics
                          ? () async {
                              bool? shouldRefresh = await context.router
                                  .push<bool>(TagsViewRoute(user: currUser, fromFeed: true));
                              if (shouldRefresh ?? false) {
                                // REFRESH PAGE
                                onTopicChanged();
                              }
                            }
                          : null,
                      radius: 5),
              if (currfilter.type == FilterTypes.sortFeedByAge)
                ageRangeStr.toText(fontSize: 13, color: AppColors.greyLight).pOnly(top: 3),
            ],
          ).pOnly(bottom: isNewRilsTab ? 5 : 0),
          trailing: Assets.svg.icons.changeSortArrows
              .svg(color: AppColors.greyLight, height: 24)
              .pad(15)
              .onTap(onFeedSort, radius: 5)
          // subtitle: newTags[tagIndex].toUpperCase().toText(fontSize: 18, medium: true).appearAll,
          )
      .pOnly(bottom: 5, top: 15);
}

Widget buildFeedTitle(FeedTypes feedType, String? desc, String? title) {
  bool isConversationTab = feedType == FeedTypes.talks;
  bool isNewRilsTab = feedType == FeedTypes.rils;

  return ListTile(
    // minVerticalPadding: 15,
    tileColor: AppColors.primaryDark,
    // horizontalTitleGap: 0,
    // leading: Assets.svg.icons.shieldTickUntitledIcon.svg(),
    title: Row(
      children: [
        isConversationTab
            ? Assets.svg.icons.messageChatCircle.svg(color: AppColors.greyLight, height: 20)
            : Assets.svg.icons.wisdomLightStar.svg(color: AppColors.greyLight, height: 20),
        // : Assets.svg.icons.shieldTickUntitledIcon.svg(color: Colors.white70),
        const SizedBox(width: 7),
        // (isNewTag ? 'EXPLORE 14-17 Y.O MEMBERS' : 'MEMBERS WHO INTERESTED IN')
        // (isQuestionsTag ? 'HELP & SHARE YOUR WISDOM' : 'EXPLORE MEMBERS')

        // (customTitle ?? (isQuestionsTag ? 'JOIN PUBLIC CONVERSATION' : 'EXPLORE MEMBERS'))

        if (desc != null) desc.toText(fontSize: 13, color: AppColors.greyLight).pOnly(top: 3)
      ],
    ).pOnly(bottom: isNewRilsTab ? 5 : 0),
    // subtitle: newTags[tagIndex].toUpperCase().toText(fontSize: 18, medium: true).appearAll,
    subtitle: title == null
        ? null
        : (title).toUpperCase().toText(
              fontSize: 18,
              medium: true,
              color: AppColors.greyLight,
            ),
  ).pOnly(bottom: 5);
}

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
