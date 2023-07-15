// ignore_for_file: use_build_context_synchronously

import 'package:example/common/extensions/extensions.dart';
import 'package:example/widgets/components/postBlock_stf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:rive/rive.dart';

import '../../../common/models/post/post_model.dart';
import '../../../common/models/report/report_model.dart';
import '../../../common/service/Database/firebase_db.dart';
import '../../../common/service/mixins/assets.gen.dart';
import '../../../common/themes/app_colors_inverted.dart';
import '../../../screens/feed_ui/create_post_screen.dart';
import '../../../screens/feed_ui/main_feed_screen.dart';
import '../../../screens/main_ui/admin_screen.dart';
import '../../../screens/main_ui/notification_screen.dart';
import 'bottom_sort_sheet.dart';
import 'feedTitle.dart';

Future showBottomSortBySheet(BuildContext context) async {
  await showModalBottomSheet(
    barrierColor: Colors.black26,
    backgroundColor: AppColors.transparent,
    context: context,
    builder: (BuildContext context) => const BottomSortSheet(),
  );
  if (context.uniProvider.sortFeedBy.type == FilterTypes.sortFeedByLocation) {
    await updateUserLocationIfNeeded(context, force: true);
  }
}

Widget buildFeed(
  BuildContext context,
  List<PostModel> postList,
  bool splashLoader, {
  String? desc,
  String? title,
  List<ReportModel>? reportList,
  required RefreshCallback onRefreshIndicator,
  required EndOfPageListenerCallback onEndOfPage,
  required FeedTypes feedType,
}) {
  print('START: buildFeed() - ${feedType.name}');

  // if (splashLoader) return basicLoader();
  if (splashLoader) {
    return basicLoaderRiltopia();
  }

  return LazyLoadScrollView(
      scrollOffset: 1500,
      onEndOfPage: onEndOfPage ?? () async {},
      child: RefreshIndicator(
          backgroundColor: AppColors.primaryOriginal,
          color: AppColors.darkBg,
          strokeWidth: 2,
          onRefresh: onRefreshIndicator,
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                context.uniProvider.showFabUpdate(false);
              } else if (direction == ScrollDirection.forward) {
                context.uniProvider.showFabUpdate(true);
              }
              // setState(() {});
              return true;
            },
            child: ListView(
              children: [
                if (feedType == FeedTypes.notifications)
                  const Divider(thickness: 2, color: AppColors.darkGrey),

                if (feedType == FeedTypes.reports && (desc != null || title != null))
                  buildFeedTitle(feedType, desc, title),

                if (feedType == FeedTypes.rils)
                  buildFeedSort(
                    context,
                    feedType,
                    onTopicChanged: onRefreshIndicator,
                    onFeedSort: () async {
                      await showBottomSortBySheet(context);
                      onRefreshIndicator();
                    },
                  ),
                1.verticalSpace,

                postList.isEmpty
                    ? 'New ${feedType.name.toCapitalized()} will appear here'
                        .toText(color: AppColors.grey50)
                        .pOnly(top: context.height * 0.25)
                        .center
                    //
                    : ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: postList.length,
                        itemBuilder: (BuildContext context, int i) {
                          bool isShowAd = i != 0 && (i ~/ 7) == (i / 7); // AKA Every 10 posts.

                          // PostView(postList[i])
                          String reportByTitle = '';
                          bool isComment = postList[i].originalPostId != null;
                          if (reportList != null) {
                            reportByTitle += '(${reportList[i].reportStatus?.name}) ';
                            reportByTitle += reportList[i].reportedUser != null
                                ? 'User '
                                : (isComment ? 'Comment ' : 'Ril ');
                            reportByTitle += 'Reported by ${reportList[i].reportedBy} :';
                          }

                          return Column(children: [
                            //> if (isShowAd) getAd(context),

                            if (feedType == FeedTypes.notifications) ...[
                              buildNotification(postList[i])
                            ] else if (feedType == FeedTypes.reports && reportList != null) ...[
                              buildReportBlock(reportList[i], isComment)
                            ] else ...[
                              PostBlock(postList[i], report: reportList?.first),
                            ],
                          ]);
                        }).appearOpacity,
                //     )
              ],
            ),
          )));
}
