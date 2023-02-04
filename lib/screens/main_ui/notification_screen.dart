import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../widgets/components/postBlock_sts.dart';
import '../../widgets/components/reported_user_block.dart';
import '../feed_ui/main_feed_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('START: onWillPop()');
        // ChatService.resetChatUnread(context, widget.chatId);
        // context.uniProvider.updateActiveChat(widget.chat?.copyWith(
        //   messages: messages,
        //   lastMessage: messages.last,
        //   unreadCounter: 0,
        // ));
        Navigator.pop(context);
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.primaryDark,
          appBar: darkAppBar(
            centerTitle: true,
            context,
            title: 'Notifications',
            hideBackButton: true,
          ),
          body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, i) {
              var notifySample = Sample.post;
              return buildNotification(notifySample);
            },
          ),
        ),
      ),
    );
  }

  Builder buildNotification(PostModel comment) {
    return Builder(builder: (context) {
      var userName = comment.creatorUser?.name ?? '';
      var shortName =
          userName.length > 19 ? userName.substring(0, 19) + '...'.toString() : userName;
      var postAgo = postTime(comment.timestamp!);
      var notifyText = 'commented on your Ril';

      var isCreatorComment = true;
      var isCurrUserComment = comment.creatorUser?.uid == context.uniProvider.currUser.uid;
      var isCurrUserAdmin = context.uniProvider.currUser.userType == UserTypes.admin;

      return Column(
        children: [
          const Divider(thickness: 2, color: AppColors.darkOutline),
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('${comment.creatorUser!.photoUrl}'),
                    backgroundColor: AppColors.darkOutline,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                        radius: 9,
                        backgroundColor: AppColors.primaryDark,
                        child:
                            Assets.svg.icons.messageTextCircle02.svg(color: Colors.white).pad(3)),
                  )
                ],
              ).pad(4).onTap(() {
                print('PROFILE CLICKED');
                context.router.push(UserRoute(user: comment.creatorUser!));
              }),
              6.horizontalSpace,
              Builder(builder: (dialogContext) {
                var isHebComment = comment.textContent.isHebrew;
                return Column(
                  crossAxisAlignment:
                      isHebComment ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        2.horizontalSpace,
                        isHebComment
                            ? notifyText.toText(color: AppColors.grey50, fontSize: 12)
                            : shortName.toText(fontSize: 12, bold: true, color: AppColors.white),
                        10.horizontalSpace,
                        isHebComment
                            ? shortName.toText(fontSize: 12, bold: true, color: AppColors.white)
                            : notifyText.toText(color: AppColors.grey50, fontSize: 12)
                      ],
                    ),
                    7.verticalSpace,
                    Container(
                      color: AppColors.chatBubble,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          comment.textContent.toTextExpanded(
                              autoExpanded: true,
                              textDirection: isHebComment ? TextDirection.rtl : TextDirection.ltr,
                              textAlign: isHebComment ? TextAlign.right : TextAlign.left,
                              style: AppStyles.text12PxRegular.copyWith(
                                color: AppColors.grey50,
                                fontSize: 14,
                              )),
                          7.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              'Show Ril'
                                  .toText(fontSize: 12, bold: true, color: AppColors.white)
                                  .pOnly(right: 5, top: 5, bottom: 10)
                                  .onTap(() async {}, radius: 5),
                              10.horizontalSpace,
                              postAgo.toText(color: AppColors.grey50, fontSize: 12)
                            ],
                          ),
                        ],
                      ).pOnly(top: 10),
                    ).rounded(radius: 8),
                  ],
                ).expanded();
              }),
            ],
          ).px(15).py(15),
        ],
      );
    });
  }
}
