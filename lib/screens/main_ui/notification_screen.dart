import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/appConfig/app_config_model.dart';
import 'package:example/common/models/report/report_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';
import 'dart:io' show Platform;

// import 'package:example/common/service/Auth/firebase_db.dart';
import 'package:example/common/dump/postViewOld_sts.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/extensions/color_printer.dart';
import '../../common/models/message/message_model.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/sampleModels.dart';
import '../../common/models/universalModel.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Auth/auth_services.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/config/check_app_update.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/components/feed/buildFeed.dart';
import '../../widgets/components/postBlock_stf.dart';
import '../../widgets/components/reported_user_block.dart';
import '../feed_ui/comments_chat_screen.dart';
import '../feed_ui/main_feed_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  bool splashLoader = true;
  List<PostModel> postList = [];
  var activeFilter = FilterTypes.notificationsPostByUser;

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  Future _loadMore({bool refresh = false}) async {
    print('START: NOTIFICATIONS _loadMore()');

    if (refresh) {
      splashLoader = true;
      postList = [];
      setState(() {});
    }

    List newPosts = await Database.advanced.handleGetModel(
      context,
      ModelTypes.posts,
      postList,
      filter: activeFilter,
      // collectionReference: 'reports/Reported users/users',
    );

    if (newPosts.isNotEmpty) postList = [...newPosts];
    print('NOTIFICATIONS POSTS: ${newPosts.length}');
    splashLoader = false;

    // Temp fix
    setState(() {});
    // Future.delayed(350.milliseconds).then((_) => setState(() {}));
    // Future.delayed(350.milliseconds).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    print('START: AdminScreen()');

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: darkAppBar(
        centerTitle: true,
        context,
        title: 'Notifications',
        hideBackButton: true,
      ),
      body: Builder(builder: (context) {
        return buildFeed(
          // desc: 'NEW ACTIVITY & COMMENTS',
          context,
          postList,
          splashLoader,
          feedType: FeedTypes.notifications,
          onRefreshIndicator: () async {
            printGreen('START: onRefresh()');
            await _loadMore(refresh: true);
          },
          onEndOfPage: () async {
            printGreen('START: onEndOfPage()');
            await _loadMore();
          },
        );
      }),
    );
  }
}

Builder buildNotification(PostModel notification) {
  return Builder(builder: (context) {
    var user = notification.creatorUser;
    var userName = user!.name ?? '';
    var shortName = userName.length > 19 ? userName.substring(0, 19) + '...'.toString() : userName;
    var postAgo = postTime(notification.timestamp!);
    var notifyText = 'You have new comment on:';

    return Column(
      children: [
        const Divider(thickness: 2, color: AppColors.darkOutline),
        Row(
          children: [
            // Stack(
            //   children: [
            //     CircleAvatar(
            //       radius: 24,
            //       backgroundImage: NetworkImage('${user.photoUrl}'),
            //       backgroundColor: AppColors.darkOutline,
            //     ),
            //     Positioned(
            //       bottom: 0,
            //       right: 0,
            //       child: CircleAvatar(
            //           radius: 9,
            //           backgroundColor: AppColors.primaryDark,
            //           child: Assets.svg.icons.messageTextCircle02.svg(color: Colors.white).pad(3)),
            //     )
            //   ],
            // ).pad(4).onTap(() {
            //   print('PROFILE CLICKED');
            //   context.router.push(UserRoute(user: user));
            // }),
            6.horizontalSpace,
            StatefulBuilder(builder: (context, stfSetState) {
              var isHebComment = notification.textContent.isHebrew;
              return Column(
                crossAxisAlignment:
                    isHebComment ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      4.horizontalSpace,
                      if (notification.notificationsCounter != 0)
                        const CircleAvatar(
                          backgroundColor: AppColors.errRed,
                          radius: 3.5,
                        ),
                      8.horizontalSpace,
                      // shortName.toText(fontSize: 13, bold: true, color: AppColors.white),
                      // 10.horizontalSpace,
                      notifyText.toText(color: AppColors.grey50, fontSize: 12)
                    ],
                  ),
                  7.verticalSpace,
                  Container(
                    color: AppColors.chatBubble,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment:
                          isHebComment ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        (notification.textContent ?? '').toTextExpanded(
                            autoExpanded: true,
                            textDirection: isHebComment ? TextDirection.rtl : TextDirection.ltr,
                            textAlign: isHebComment ? TextAlign.right : TextAlign.left,
                            style: AppStyles.text14PxRegular.copyWith(
                              color: AppColors.grey50,
                            )),
                        7.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            'Show Ril'
                                .toText(fontSize: 13, bold: true, color: AppColors.white)
                                .pOnly(right: 5, top: 5, bottom: 10),
                            // .onTap(() => handleShowBottomPost(context, notification), radius: 5),
                            10.horizontalSpace,
                            postAgo.toText(color: AppColors.grey50, fontSize: 12)
                          ],
                        ),
                      ],
                    ).pOnly(top: 10),
                  ).rounded(radius: 8).pad(3).onTap(() {
                    handleShowBottomPost(context, notification);
                    FeedService.resetPostUnread(context, notification.id);
                    notification = notification.copyWith(notificationsCounter: 0);
                    stfSetState(() {});
                  }, radius: 10),
                ],
              ).expanded();
            }),
          ],
        ).px(15).py(15),
      ],
    );
  });
}
