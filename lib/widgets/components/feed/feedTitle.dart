import 'package:example/common/extensions/extensions.dart';
import '../../../common/models/report/report_model.dart';
import '../../../common/service/Database/firebase_db.dart';
import '../../../common/service/mixins/assets.gen.dart';
import '../../../common/themes/app_colors_inverted.dart';
import '../../../screens/feed_ui/main_feed_screen.dart';
import '../../../screens/main_ui/admin_screen.dart';
import '../../../screens/main_ui/notification_screen.dart';
import 'package:flutter/material.dart';

import 'bottom_sort_sheet.dart';

Widget basicLoader() =>
    const CircularProgressIndicator(color: AppColors.primaryOriginal, strokeWidth: 6).center;

Widget buildFeedSort(
  BuildContext context,
  FeedTypes feedType, {
  required GestureTapCallback onFeedSort,
}) {
  bool isConversationTab = feedType == FeedTypes.conversations;
  bool isNewRilsTab = feedType == FeedTypes.members;
  final currfilter = context.uniProvider.sortFeedBy;

  return ListTile(
      // minVerticalPadding: 15,
      tileColor: AppColors.primaryDark,
      // horizontalTitleGap: 0,
      // leading: Assets.svg.icons.shieldTickUntitledIcon.svg(),
      title: Row(
        children: [
          currfilter.solidSvg.svg(color: AppColors.yellowAlert, height: 20),
          const SizedBox(width: 7),
          'Sort Rils by '.toText(fontSize: 13, color: AppColors.greyLight).pOnly(top: 3),
          currfilter.title
              .replaceAll('sortFeedBy', '')
              .toText(bold: true, fontSize: 13, color: AppColors.white)
              .pOnly(top: 3)
        ],
      ).pOnly(bottom: isNewRilsTab ? 5 : 0),
      trailing: Assets.svg.icons.changeSortArrows
          .svg(color: AppColors.greyLight, height: 24)
          .pad(15)
          .onTap(
            onFeedSort,
            radius: 5,
          )
      // subtitle: newTags[tagIndex].toUpperCase().toText(fontSize: 18, medium: true).appearAll,
      ).pOnly(bottom: 5, top: 15);
}

Widget buildFeedTitle(FeedTypes feedType, String? desc, String? title) {
  bool isConversationTab = feedType == FeedTypes.conversations;
  bool isNewRilsTab = feedType == FeedTypes.members;

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
