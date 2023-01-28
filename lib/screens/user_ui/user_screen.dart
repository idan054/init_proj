import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';
import 'package:collection/collection.dart'; // You have to add this manually,
// import 'package:example/common/service/Auth/firebase_db.dart';
import 'package:example/common/dump/postViewOld_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../common/models/post/post_model.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/clean_snackbar.dart';
import '../../widgets/components/postBlock_sts.dart';
import '../../widgets/my_dialog.dart';

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
  var isBioExpanded = false;

  @override
  void initState() {
    print('START: initState()');
    _loadMore();
    super.initState();
  }

  // User posts
  Future _loadMore({bool refresh = false}) async {
    print('START: USER _loadMore()');

    // splashLoader = true; setState(() {});
    if (refresh) postList = [];
    List newPosts = await Database.advanced.handleGetModel(
      ModelTypes.posts,
      postList,
      filter: activeFilter,
      uid: widget.user.uid,
    );

    if (newPosts.isNotEmpty) postList = [...newPosts];
    print('postList ${postList.length}');
    // splashLoader = false;
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
            scrollOffset: 1500,
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
                        Container(
                          color: AppColors.darkOutline,
                          child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: postList.length,
                              itemBuilder: (BuildContext context, int i) {
                                // PostView(postList[i])
                                return PostBlock(postList[i], isUserPage: true);
                              }),
                        ),
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
          var title = isCurrUserProfile ? 'Your Rils' : "Rils";
          // return title.toText(fontSize: 18, medium: true).centerLeft.py(12).px(25);
          return TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: const BorderSide(width: 2.5, color: AppColors.primaryOriginal),
                insets: 30.horizontal),
            labelStyle: AppStyles.text14PxRegular,
            indicatorColor: AppColors.primaryOriginal,
            tabs: [
              Tab(text: title),
              Tab(text: "${user.name}'s Conversions"),

              // Tab(text: 'Latest'),
              // Tab(text: 'Questions'),
            ],
            onTap: (value) async {
              if (value == 0) activeFilter = FilterTypes.postsByUser;
              if (value == 1) activeFilter = FilterTypes.postConversionsOfUser;
              context.uniProvider.updateFeedStatus(activeFilter);
              await _loadMore(refresh: true);
            },
          );
          // .pOnly(bottom: 6);
        }),
      ),
    );
  }

  Container buildTopProfile(double topPadding, BuildContext context, bool isCurrUserProfile) {
    return Container(
      height: topPadding,
      color: AppColors.darkOutline,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.darkOutline50,
            // child: Icons.arrow_back_rounded.icon(size: 18, color: AppColors.white),
            child: Assets.svg.icons.arrowBackLeft.svg(height: 14, color: AppColors.white),
          ).onTap(() {
            widget.fromEditScreen
                ? context.router.replaceAll([DashboardRoute()])
                : Navigator.pop(context);
          }),
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.darkOutline50,
            child: PopupMenuButton(
                icon: Assets.svg.moreVert.svg(height: 18, color: AppColors.white),
                shape: 10.roundedShape,
                color: AppColors.darkOutline50,
                itemBuilder: (context) {
                  return [
                    if (isCurrUserProfile) ...[
                      PopupMenuItem(
                        onTap: () {
                          context.router.push(EditUserRoute(user: context.uniProvider.currUser));
                        },
                        child: 'Edit profile'.toText(),
                      ),
                    ] else ...[
                      PopupMenuItem(
                        onTap: () => reportUserPopup(context, widget.user),
                        child: 'Report member'.toText(),
                      ),
                      // PopupMenuItem(
                      //   // TODO LATER LIST: Add Block user action
                      //   child: 'Block member'.toText(),
                      // ),
                    ]
                  ];
                }),
          ),
        ],
      ).px(20),
    );
  }

  void reportUserPopup(BuildContext context, UserModel user) {
    var reasonController = TextEditingController();
    final reportFormKey = GlobalKey<FormState>();

    Future.delayed(150.milliseconds).then((_) {
      String userName = '${user.name}';
      showRilDialog(context,
          title: 'Report "$userName"',
          desc: Form(
            key: reportFormKey,
            child: rilTextField(
              px: 0,
              label: 'Reason why',
              controller: reasonController,
              validator: (value) {
                if (value(' ', '').isEmpty) return '';
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
                var docName = userName.substring(0, nameEndAt).toString() + UniqueKey().toString();

                Database.updateFirestore(
                  collection: 'reports/Reported users/users',
                  docName: docName,
                  toJson: {
                    'reportAt': Timestamp.fromDate(DateTime.now()),
                    'reportedBy': context.uniProvider.currUser.uid,
                    'reasonWhy': reasonController.text,
                    'userName': userName,
                    'status': 'New',
                    'type': 'User',
                    'user': user.toJson()
                  },
                );
                Navigator.of(context).pop();
                rilFlushBar(context, 'Thanks, We\'ll handle it asap');
              },
              child: 'Report'.toText(color: AppColors.primaryLight)));
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
              radius: 46,
              backgroundColor: AppColors.darkOutline,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoUrl!),
                backgroundColor: AppColors.darkGrey,
              ).center,
            ),
            buildOnlineBadge(ratio: 1.8),
          ],
        ),
        16.verticalSpace,
        '${user.name}'.toText(fontSize: 18, medium: true),
        8.verticalSpace,
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
                      user.tags.isEmpty
                          ? const Offstage()
                          : user.tags.length == 1
                              ? buildRilChip(user.tags.first)
                              : Badge(
                                      badgeContent: '+${user.tags.length - 1}'.toText(
                                          fontSize: 10, color: Colors.white70, medium: true),
                                      padding: const EdgeInsets.all(5),
                                      elevation: 0,
                                      badgeColor: AppColors.darkOutline50,
                                      // stackFit: StackFit.loose,
                                      // shape:
                                      child: buildRilChip(user.tags.first))
                                  .pad(7)
                                  .onTap(() {
                                  showTagsRow = !showTagsRow;
                                  stfSetState(() {});
                                }, radius: 12),
                      12.horizontalSpace,
                      buildRilChip('${user.gender?.name}', icon: Assets.svg.icons.manProfile.svg()),
                      12.horizontalSpace,
                      buildRilChip('${user.age} y.o',
                          icon: Assets.svg.icons.dateTimeCalender.svg()),
                      if (user.userType == UserTypes.admin) ...[
                        12.horizontalSpace,
                        buildRilChip('Admin',
                            icon: Opacity(
                                opacity: 0.8,
                                child: Assets.images.riltopiaAsIconPNG.image(height: 14))),
                      ]
                    ],
                  ),
                );
        }),
        8.verticalSpace,
        StatefulBuilder(builder: (context, stfSetState) {
          var haveBio = user.bio != null && user.bio!.isNotEmpty;

          return Column(
            children: [
              !haveBio && !isCurrUser
                  ? const Offstage()
                  : buildExpandableText(haveBio ? '${user.bio}' : 'Edit your bio',
                          // 'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          // 'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          // 'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          // 'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already ',
                          onChanged: (val) {
                      isBioExpanded = !isBioExpanded;
                      stfSetState(() {});
                    },
                          style: AppStyles.text14PxRegular.copyWith(
                              color: AppColors.grey50,
                              decoration: haveBio ? null : TextDecoration.underline))
                      .px(12)
                      .py(6)
                      .onTap(
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
                      backgroundColor: AppColors.primaryLight2,
                      // side: const BorderSide(width: 2.0, color: AppColors.primaryLight2),
                      // foregroundColor: AppColors.darkOutline,
                      shape: 8.roundedShape,
                    ),
                    icon: Assets.svg.icons.dmPlaneUntitledIcon
                        .svg(height: 17, color: AppColors.darkBg),
                    label: 'Reply bio'.toText(fontSize: 13, color: AppColors.darkBg, bold: true),
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
                SizedBox(
                  width: context.width * 0.5,
                  height: 40,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      // backgroundColor: AppColors.primaryLight2,
                      backgroundColor: AppColors.transparent,
                      side: const BorderSide(width: 2.0, color: AppColors.primaryLight2),
                      shape: 8.roundedShape,
                    ),
                    icon: Assets.svg.icons.dmPlaneUntitledIcon
                        .svg(height: 17, color: AppColors.primaryLight2),
                    label:
                        'Send DM'.toText(fontSize: 13, color: AppColors.primaryLight2, bold: true),
                    onPressed: () {
                      ChatService.openChat(context, otherUser: user);
                    },
                  ),
                ),
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
                                .pOnly(right: 10),
                            "You both interesting in $commonTag... that's cool!"
                                .toText(color: AppColors.grey50, fontSize: 12)
                                // .expanded(),
                          ],
                        );
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
                    icon:
                        addonName != 'Edit' ? null : Icons.edit_rounded.icon(color: Colors.white70))
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
      label: label.toText(fontSize: 13, color: Colors.white70),
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
      expandText: 'Expand',
      collapseText: 'Collape',
      expanded: autoExpanded,
      linkColor: linkColor ?? AppColors.primaryLight2,
      animation: true,
      animationDuration: 1000.milliseconds,
      textDirection: textDirection,
      linkStyle: AppStyles.text14PxMedium,
      style: style ?? AppStyles.text14PxRegular.copyWith(color: AppColors.grey50));
}
