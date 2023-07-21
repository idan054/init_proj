import 'dart:developer';

import 'package:badges/badges.dart' as badge;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/screens/auth_ui/a_onboarding_screen.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';
import 'package:collection/collection.dart'; // You have to add this manually,
// import 'package:example/common/service/Auth/firebase_db.dart';
import 'package:example/common/dump/postViewOld_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../common/models/post/post_model.dart';
import '../../common/models/report/report_model.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/clean_snackbar.dart';
import '../../widgets/components/feed/feedTitle.dart';
import '../../widgets/components/postBlock_stf.dart';
import '../../widgets/my_dialog.dart';
import '../feed_ui/main_feed_screen.dart';

class UserScreen extends StatefulWidget {
  final bool fromEditScreen;
  final UserModel user;

  const UserScreen(this.user, {this.fromEditScreen = false, Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<PostModel> postList = [];
  var activeFilter = FilterTypes.postsByUser;
  var isLoading = true;
  var isBioExpanded = false;
  bool isBlocked = false;

  @override
  void initState() {
    print('START: initState()');
    isBlocked = widget.user.userType == UserTypes.blocked ||
        context.uniProvider.currUser.blockedUsers.contains(widget.user.uid);
    context.uniProvider.fetchedUsers.remove(widget.user); // No rebuild
    _loadMore(refresh: true);
    super.initState();
  }

  // User posts
  Future _loadMore({bool refresh = false}) async {
    print('START: USER _loadMore()');
    context.uniProvider.currFilterUpdate(activeFilter, notify: false);

    if (refresh) {
      postList = [];
      isLoading = true;
      setState(() {});
    }

    List newPosts = await Database.advanced.handleGetModel(
      context,
      ModelTypes.posts,
      postList,
      filter: activeFilter,
      otherUser: widget.user,
    );

    if (newPosts.isNotEmpty) postList = [...newPosts];
    // print('postList ${postList.length}');
    if (refresh) {
      isLoading = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: PostScreen()');
    var topPadding = 100.0;
    var user = widget.user;
    var currUser = context.listenUniProvider.currUser;
    var isCurrUserProfile = currUser.uid == user.uid;

    return WillPopScope(
      onWillPop: () async {
        widget.fromEditScreen
            ? context.router.replaceAll([DashboardRoute()])
            : Navigator.pop(context);
        return false;
      },
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: Scaffold(
          backgroundColor: AppColors.darkBg,
          body: LazyLoadScrollView(
            scrollOffset: 500,
            onEndOfPage: () async {
              printGreen('START: user_screen.dart onEndOfPage()');
              await _loadMore();
            },
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: ListView(
                children: [
                  buildTopProfile(topPadding, context, isCurrUserProfile),
                  Transform.translate(
                    offset: Offset(0, -(topPadding * 0.50)),
                    child: Column(
                      children: [
                        buildBottomProfile(context, user),
                        // const Divider(thickness: 2, color: AppColors.darkOutline),
                        5.verticalSpace,
                        buildPostsDivider(isCurrUserProfile, user),
                        Builder(builder: (context) {
                          if (isLoading) return basicLoader().pOnly(top: 100);

                          var text = activeFilter == FilterTypes.postsByUser
                              ? "${isCurrUserProfile ? 'Your'.tr() : "${user.name}'s"} Rils" "${'will appear here'.tr()}"
                              : '${isCurrUserProfile ? '' : "${user.name}"}' "${'Talks'.tr()}" "${'will appear here'.tr()}";

                          if (postList.isEmpty || isBlocked) {
                            return text.toText(color: AppColors.grey50).pOnly(top: 100);
                          }

                          return Container(
                            color: AppColors.darkOutline,
                            child: ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: postList.length,
                                itemBuilder: (BuildContext context, int i) {
                                  // PostView(postList[i])
                                  return PostBlock(postList[i], isUserPage: true);
                                }),
                          );
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ClipRRect buildPostsDivider(bool isCurrUserProfile, UserModel user) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: 10.circular, topRight: 10.circular),
      child: Container(
        padding: 5.vertical,
        color: AppColors.primaryDark,
        child: Builder(builder: (context) {
          // var rilTitle = isCurrUserProfile ? 'Your Rils' : "Rils";
          var rilTitle = "Rils";
          var convTitle = 'Talks'.tr();
          // var convTitle = isCurrUserProfile ? 'Talks'.tr() : (context.hebLocale ? ("השיחות של " "${user.name}") : "${user.name}'s Talks");

          // return title.toText(fontSize: 18, medium: true).centerLeft.py(12).px(25);
          return TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: const BorderSide(width: 2.5, color: AppColors.primaryOriginal),
                insets: 30.horizontal),
            labelStyle: AppStyles.text14PxRegular,
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.greyLight,
            indicatorColor: AppColors.primaryOriginal,
            tabs: [
              Tab(text: rilTitle),
              Tab(text: convTitle),

              // Tab(text: 'Latest'),
              // Tab(text: 'Questions'),
            ],
            onTap: (value) async {
              if (value == 0) activeFilter = FilterTypes.postsByUser;
              if (value == 1) activeFilter = FilterTypes.conversationsPostByUser;
              context.uniProvider.currFilterUpdate(activeFilter);
              await _loadMore(refresh: true);
            },
          );
          // .pOnly(bottom: 6);
        }),
      ),
    );
  }

  Container buildTopProfile(double topPadding, BuildContext context, bool isCurrUserProfile) {
    var currUser = context.uniProvider.currUser;

    return Container(
      height: topPadding,
      // color: AppColors.darkOutline,
      color: AppColors.primaryOriginal,
      child: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: topPadding,
            child: Assets.images.squresBg.image(fit: BoxFit.cover),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: context.hebLocale ? 2 : 4,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black45,
                  // backgroundColor: AppColors.darkOutline50,
                  // child: Icons.arrow_back_rounded.icon(size: 18, color: AppColors.white),
                  child: Assets.svg.icons.arrowBackLeft.svg(height: 14, color: AppColors.darkBg),
                ).onTap(() {
                  widget.fromEditScreen
                      ? context.router.replaceAll([DashboardRoute()])
                      : Navigator.pop(context);
                }),
              ),
              // Email also show to admins on 'Admin delete Ril'
              // if (currUser.userType == UserTypes.admin)
              //   widget.user.email.toString().toText(color: AppColors.grey50).pOnly(bottom: 20),

              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black45,
                // backgroundColor: AppColors.darkOutline50,
                child: PopupMenuButton(
                    icon: Assets.svg.moreVert.svg(height: 18, color: AppColors.darkBg),
                    shape: 10.roundedShape,
                    color: AppColors.lightOutline50,
                    itemBuilder: (context) {
                      return [
                        if (isCurrUserProfile) ...[
                          PopupMenuItem(
                            onTap: () {
                              context.router
                                  .push(EditUserRoute(user: context.uniProvider.currUser));
                            },
                            child: 'Edit profile'.toText(),
                          ),
                        ] else ...[
                          PopupMenuItem(
                            onTap: () => reportUserPopup(context, widget.user),
                            child: 'Report member'.toText(),
                          ),
                          PopupMenuItem(
                            onTap: () => blockUserPopup(context, widget.user),
                            child: (isBlocked ? 'Unblock member' : 'Block member').toText(),
                          ),
                        ]
                      ];
                    }),
              ),
            ],
          ).px(20).pOnly(top: 15),
        ],
      ),
    );
  }

  void reportUserPopup(BuildContext context, UserModel user) {
    var reasonController = TextEditingController();
    final reportFormKey = GlobalKey<FormState>();

    Future.delayed(150.milliseconds).then((_) {
      String userName = '${user.name}';
      showRilDialog(context,
          title: "${'Report'.tr()}" " " "$userName",
          desc: Form(
            key: reportFormKey,
            child: rilTextField(
              px: 0,
              label: 'Reason why',
              controller: reasonController,
              validator: (value) {
                if (value.toString().replaceAll(' ', '').isEmpty) return '';
                return '$value'.isEmpty ? '' : null;
              },
            ),
          ),
          barrierDismissible: true,
          secondaryBtn: TextButton(
              onPressed: () {
                var validState = reportFormKey.currentState!.validate();
                if (!validState) return;

                var nameEndAt = userName.length < 20 ? userName.length : 20;
                var docName =
                    'REPORT: ${userName.substring(0, nameEndAt).toString() + UniqueKey().toString()}';

                var postReport = ReportModel(
                  timestamp: DateTime.now(),
                  reportedBy: context.uniProvider.currUser.name,
                  // reportedPost: ,
                  reportedUser: user,
                  reasonWhy: reasonController.text,
                  reportStatus: ReportStatus.newReport,
                  reportType: ReportType.user,
                  userName: userName,
                );

                Database.updateFirestore(
                    collection: 'reports/Reported users/users',
                    docName: docName,
                    toJson: postReport.toJson());
                Navigator.of(context).pop();
                rilFlushBar(context, 'Thanks, We\'ll handle it asap');
              },
              child: 'Report'.toText(color: AppColors.primaryLight)));
    });
  }

  void blockUserPopup(BuildContext context, UserModel user) {
    var currUser = context.uniProvider.currUser;

    Future.delayed(150.milliseconds).then((_) {
      String userName = '${user.name}';
      showRilDialog(context,
          title: isBlocked ? "${'Unblock'.tr()}" '?' : 'Are you sure?'.tr(),
          desc: (isBlocked
                  ? "${'You will see content from '.tr()}"
              '\n$userName \n'
                  : "${'You will not see content from '.tr()}"
              '\n$userName \n')
              // 'You can\'t Undo it. Are you sure?'
              .toText(maxLines: 10),
          barrierDismissible: true,
          secondaryBtn: TextButton(
              onPressed: () async {
                if (isBlocked) {
                  // UnBlock action:
                  var blockedUsers = [...currUser.blockedUsers];
                  blockedUsers.remove(user.uid);
                  currUser = currUser.copyWith(blockedUsers: blockedUsers);
                  context.uniProvider.currUserUpdate(currUser);

                  Database.updateFirestore(
                    collection: 'users',
                    docName: currUser.email.toString(),
                    toJson: currUser.toJson(),
                  );

                  Navigator.of(context).pop();
                  rilFlushBar(context, '$userName' "${'unblocked'.tr()}" '.');
                  isBlocked = false;
                  setState(() {});
                } else {
                  // Block action:
                  var blockedUsers = [...currUser.blockedUsers];
                  blockedUsers.add(user.uid.toString());
                  currUser = currUser.copyWith(blockedUsers: blockedUsers);
                  context.uniProvider.currUserUpdate(currUser);

                  Database.updateFirestore(
                    collection: 'users',
                    docName: currUser.email.toString(),
                    toJson: currUser.toJson(),
                  );

                  Navigator.of(context).pop();
                  rilFlushBar(context, '$userName '
                      "${'blocked'.tr()}"
                      '.');
                  isBlocked = true;
                  setState(() {});
                }
              },
              child: (isBlocked ? 'Unblock' : 'Block').toText(color: AppColors.primaryLight)));
    });
  }

  Widget buildBottomProfile(BuildContext context, UserModel user) {
    var currUser = context.listenUniProvider.currUser;
    var isCurrUser = currUser.uid == user.uid;
    var showTagsRow = false;

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.darkBg,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoUrl!),
                backgroundColor: AppColors.darkGrey,
              ).center,
            ),
            buildOnlineBadge(context, user, ratio: 1.8),
          ],
        ),
        16.verticalSpace,
        '${user.name}'.toText(fontSize: 18, medium: true),
        16.verticalSpace,
        StatefulBuilder(builder: (context, stfSetState) {
          return showTagsRow
              ? buildTagsRow(user, addonName: '<', onAddonTap: () {
                  showTagsRow = !showTagsRow;
                  stfSetState(() {});
                })
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (user.userType == UserTypes.admin) ...[
                        12.horizontalSpace,
                        buildRilChip('Admin',
                            icon: Assets.svg.icons.riltopiaIcon
                                .svg(color: AppColors.greyLight, height: 16)),
                        12.horizontalSpace,
                      ],
                      if (!context.hebLocale) ...[
                        buildTagsChip(user, onTap: () {
                          showTagsRow = !showTagsRow;
                          stfSetState(() {});
                        }),
                        12.horizontalSpace,
                      ],
                      Builder(builder: (context) {
                        var isOther = user.gender == GenderTypes.other;
                        // 🚹 🚺 👩👨 💁‍♀️💁‍♂️
                        var genderTitle = isOther ? '🏳️‍🌈 other' : '${user.gender?.name}';
                        return buildRilChip(genderTitle,
                            icon: isOther
                                ? null
                                : Assets.svg.icons.manProfile.svg(color: AppColors.greyLight));
                      }),
                      12.horizontalSpace,
                      buildRilChip(context.hebLocale ? 'גיל ${user.age}' : '${user.age} y.o',
                          icon: Assets.svg.icons.dateTimeCalender.svg(color: AppColors.greyLight)),
                      if (context.hebLocale) ...[
                        // 12.horizontalSpace,
                        buildTagsChip(user, onTap: () {
                          showTagsRow = !showTagsRow;
                          stfSetState(() {});
                        }),
                      ],
                    ],
                  ),
                );
        }),
        8.verticalSpace,
        StatefulBuilder(builder: (context, stfSetState) {
          var haveBio = user.bio != null && user.bio!.isNotEmpty;
          // var color = AppColors.white;
          var color = AppColors.primaryOriginal;
          var bgColor = AppColors.darkBg;

          return Column(
            children: [
              !haveBio && !isCurrUser
                  ? const Offstage()
                  : buildExpandableText(
                      haveBio ? '${user.bio}' : 'Edit your bio',
                      onChanged: (val) {
                        isBioExpanded = !isBioExpanded;
                        stfSetState(() {});
                      },
                      style: AppStyles.text14PxRegular.copyWith(
                          color: AppColors.grey50,
                          decoration: haveBio ? null : TextDecoration.underline),
                    ).px(12).py(6).onTap(
                      haveBio
                          ? null
                          : () => context.router
                              .push(EditUserRoute(user: context.uniProvider.currUser)),
                      radius: 6),
              12.verticalSpace,
              if (!isCurrUser && isBioExpanded) ...[
                SizedBox(
                  width: context.width * 0.5,
                  height: 42,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      // backgroundColor: AppColors.white,
                      side: BorderSide(width: 2.0, color: color),
                      foregroundColor: AppColors.darkOutline,
                      shape: 99.roundedShape,
                    ),
                    icon: Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17, color: color),
                    label: 'Reply bio'.toText(fontSize: 13, color: color, bold: true),
                    onPressed: () {
                      // TODO LATER LIST: Add Reply bio action
                      var replyBio = PostModel(
                          creatorUser: user,
                          timestamp: DateTime.now(),
                          id: 'bio-${user.email}-${UniqueKey()}',
                          enableComments: false,
                          likeByIds: [],
                          textContent: '${user.bio}');
                      ChatService.openChat(context, otherUser: user, postReply: replyBio);
                    },
                  ),
                ),
                12.verticalSpace,
              ],
              if (!isCurrUser && !isBioExpanded) ...[
                Builder(builder: (context) {
                  return SizedBox(
                    width: context.width * 0.5,
                    height: 40,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: color,
                        // backgroundColor: AppColors.transparent,
                        side: BorderSide(width: 2.0, color: color),
                        shape: 99.roundedShape,
                      ),
                      icon: isBlocked
                          ? const Offstage()
                          : RotatedBox(
                          quarterTurns: context.hebLocale ? 3 : 4,
                          child: Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17, color: bgColor)),
                      // label: (isBlocked ? 'Blocked' : 'Send DM')
                      label: (isBlocked ? 'Blocked' : 'Start Chat')
                          .toText(fontSize: 13, color: bgColor, bold: true),
                      onPressed: isBlocked
                          ? null
                          : () {
                              ChatService.openChat(context, otherUser: user);
                            },
                    ),
                  );
                }),
                12.verticalSpace,
                Builder(builder: (context) {
                  var commonTag = user.tags.firstWhereOrNull((tag) => currUser.tags.contains(tag));
                  return commonTag == null
                      ? const Offstage()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.svg.icons.groupMultiPeople
                                .svg(width: 17, color: AppColors.grey50)
                                .px(7),
                            '${"You both interested in ".tr()}'
                                '${commonTag.tr()}'
                                "... "
                                '${"that's cool!".tr()}'
                                .toText(color: AppColors.grey50, fontSize: 12)
                            // .expanded(),
                          ],
                        ).py(3);
                }),
                if (!isCurrUser) 12.verticalSpace,
              ],
            ],
          );
        }),
      ],
    ).px(25);
  }
}

Widget buildTagsChip(UserModel user, {GestureTapCallback? onTap}) {
  return user.tags.isEmpty
      ? const Offstage()
      : user.tags.length == 1
          ? buildRilChip(user.tags.first)
          : badge.Badge(
                  badgeContent: '+${user.tags.length - 1}'
                      .toText(fontSize: 10, color: Colors.white, medium: true),
                  padding: const EdgeInsets.all(5),
                  elevation: 0,
                  badgeColor: AppColors.primaryOriginal,
                  // stackFit: StackFit.loose,
                  // shape:
                  child: buildRilChip(user.tags.first))
              .pad(7)
              .onTap(onTap, radius: 12);
}

Widget buildTagsRow(UserModel user,
    {String? addonName, GestureTapCallback? onAddonTap, Color? chipColor}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Text('${user.name}\'s interests', style: AppStyles.text14PxRegular.copyWith(color: AppColors.grey50))
      //     .pOnly(left: 12),
      Wrap(
        // mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          if (onAddonTap != null)
            buildRilChip('$addonName',
                    bgColor: chipColor,
                    icon: addonName != 'Edit'
                        ? null
                        : Icons.edit_rounded.icon(color: AppColors.greyLight))
                // .pad(7)
                .onTap(onAddonTap, radius: 12),
          // 4.horizontalSpace,
          for (var tag in user.tags) ...[
            buildRilChip(tag, bgColor: chipColor),
            // 12.horizontalSpace,
          ],
        ],
      ),
    ],
  );
}

Widget buildRilChip(String label, {Widget? icon, Color? bgColor}) {
  return Theme(
    data: ThemeData(canvasColor: Colors.transparent),
    child: Chip(
      backgroundColor: bgColor ?? AppColors.darkOutline,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      // side: BorderSide(width: 2.0, color: AppColors.transparent),
      // label: label.toText(fontSize: 13, color: Colors.white70),
      label: label.toText(fontSize: 13, color: AppColors.greyLight),
      avatar: icon,
      shape: 8.roundedShape,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}

ExpandableText buildExpandableText(
  String text, {
  TextStyle? style,
  TextAlign? textAlign,
  TextDirection? textDirection,
  int? maxLines,
  ValueChanged<bool>? onChanged,
  Color? linkColor,
  bool autoExpanded = false,
}) {
  return ExpandableText(text,
      maxLines: maxLines ?? 5,
      textAlign: textAlign ?? TextAlign.center,
      onExpandedChanged: onChanged,
      expandText: 'Expand'.tr(),
      collapseText: 'Collapse'.tr(),
      expanded: autoExpanded,
      linkColor: linkColor ?? AppColors.primaryLight,
      animation: true,
      animationDuration: 1000.milliseconds,
      textDirection: textDirection,
      linkStyle: AppStyles.text14PxMedium,
      style: style ?? AppStyles.text14PxRegular.copyWith(color: AppColors.grey50));
}

const invertMatrix = <double>[
  -1,
  0,
  0,
  0,
  255,
  0,
  -1,
  0,
  0,
  255,
  0,
  0,
  -1,
  0,
  255,
  0,
  0,
  0,
  1,
  0,
];
