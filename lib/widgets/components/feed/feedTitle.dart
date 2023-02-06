import 'package:example/common/extensions/extensions.dart';
import '../../../common/models/report/report_model.dart';
import '../../../common/service/Database/firebase_db.dart';
import '../../../common/service/mixins/assets.gen.dart';
import '../../../common/themes/app_colors.dart';
import '../../../screens/feed_ui/main_feed_screen.dart';
import '../../../screens/main_ui/admin_screen.dart';
import '../../../screens/main_ui/notification_screen.dart';
import 'package:flutter/material.dart';

Widget basicLoader() =>
    const CircularProgressIndicator(color: AppColors.primaryLight, strokeWidth: 3).center;

ListTile buildFeedTitle(FeedTypes feedType, String? desc, String? title) {
  bool isConversationTab = feedType == FeedTypes.conversations;
  bool isNewRilsTab = feedType == FeedTypes.members;

  return ListTile(
    minVerticalPadding: 25,
    tileColor: AppColors.primaryDark,
    // horizontalTitleGap: 0,
    // leading: Assets.svg.icons.shieldTickUntitledIcon.svg(),
    title: Row(
      children: [
        isConversationTab
            ? Assets.svg.icons.messageChatCircle.svg(color: AppColors.grey50, height: 20)
            : Assets.svg.icons.wisdomLightStar.svg(color: AppColors.grey50, height: 20),
        // : Assets.svg.icons.shieldTickUntitledIcon.svg(color: Colors.white70),
        const SizedBox(width: 7),
        // (isNewTag ? 'EXPLORE 14-17 Y.O MEMBERS' : 'MEMBERS WHO INTERESTED IN')
        // (isQuestionsTag ? 'HELP & SHARE YOUR WISDOM' : 'EXPLORE MEMBERS')

        // (customTitle ?? (isQuestionsTag ? 'JOIN PUBLIC CONVERSATION' : 'EXPLORE MEMBERS'))

        if (desc != null) desc.toText(fontSize: 13, color: AppColors.grey50).pOnly(top: 3)
      ],
    ).pOnly(bottom: isNewRilsTab ? 15 : 0),
    // subtitle: newTags[tagIndex].toUpperCase().toText(fontSize: 18, medium: true).appearAll,
    subtitle: title == null ? null : (title).toUpperCase().toText(fontSize: 18, medium: true),
  );
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
