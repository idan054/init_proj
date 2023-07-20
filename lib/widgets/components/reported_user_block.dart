// ignore_for_file: no_leading_underscores_for_local_identifiers, sort_child_properties_last

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/widgets/components/postBlock_stf.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/report/report_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_colors_inverted.dart';
import '../../common/themes/app_styles.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../screens/feed_ui/comments_chat_screen.dart';
import 'package:intl/intl.dart' as intl;
import '../../screens/user_ui/user_screen.dart';
import '../clean_snackbar.dart';
import '../my_dialog.dart';

class ReportedUserBlock extends StatelessWidget {
  final ReportModel report;

  const ReportedUserBlock(this.report, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reasonWhy = report.reasonWhy ?? '';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      color: AppColors.primaryDark,
      child: Column(
        children: [
          if (report.reportedUser != null)
            buildProfile(context), // Doesn't require 55 Left padding.
          Column(
            children: [
              buildExpandableText(reasonWhy,
                      maxLines: 4,
                      textAlign: reasonWhy.isHebrew ? TextAlign.right : TextAlign.left,
                      textDirection:
                          reasonWhy.isHebrew ? TextDirection.rtl : TextDirection.ltr,
                      style: AppStyles.text16PxRegular.copyWith(color: AppColors.white))
                  .pOnly(right: 20, bottom: 10)
                  .advancedSizedBox(context, maxWidth: true),
            ],
            // ).pOnly(left: 5)
          ).pOnly(left: 55)
        ],
      ).pOnly(left: 15),
    );
  }

  Widget buildProfile(BuildContext context) {
    var currUser = context.uniProvider.currUser;
    var reportedUser = report.reportedUser!;
    // var postAgo = postTime(report.timestamp!);

    return SizedBox(
        height: 65,
        // height: 72, // 72: original size 60: min size
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          // title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.grey50),
          title: '${reportedUser.name}'
              .toText(fontSize: 14, bold: true, color: AppColors.white, textAlign: TextAlign.left),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO ADD ON POST MVP ONLY (ago · Tag (Add Tags))
              'Reason:'
                  .toText(color: AppColors.grey50, fontSize: 12)
                  .pOnly(right: 10, top: 4, bottom: 5)
              // .onTap(() {}, radius: 10), // TODO Add move to Tag
            ],
          ),
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('${reportedUser!.photoUrl}'),
                backgroundColor: AppColors.darkOutline,
              ),
            ],
          ).pad(0).onTap(() {
            print('PROFILE CLICKED');
            context.router.push(UserRoute(user: reportedUser));
          }, radius: 5),
          // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
          trailing: PopupMenuButton(
              icon: Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50),
              shape: 10.roundedShape,
              color: AppColors.lightOutline50,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: 'BLOCK From Riltopia'.toText(),
                      onTap: () {
                        blockUserFromRiltopiaPopup(context, reportedUser);
                      }),
                ];
              }),
        ));
  }

  void blockUserFromRiltopiaPopup(BuildContext context, UserModel user) {
    Future.delayed(150.milliseconds).then((_) {
      String userName = '${user.name}';
      showRilDialog(context,
          title: 'Are you sure?',
          desc: 'Once member blocked, he can only chat with Riltopia Team'
              // 'You can\'t Undo it. Are you sure?'
              .toText(maxLines: 10),
          barrierDismissible: true,
          secondaryBtn: TextButton(
              onPressed: () async {
                Database.updateFirestore(
                  collection: 'users',
                  docName: user.email.toString(),
                  toJson: {'userType': UserTypes.blocked.name},
                );

                Navigator.of(context).pop();
                rilFlushBar(context, '$userName blocked.');
              },
              child: ('BLOCK from RilTopia').toText(color: AppColors.primaryLight)));
    });
  }
}
