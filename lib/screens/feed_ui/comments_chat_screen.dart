import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../common/models/message/message_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_strings.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/components/postBlock_sts.dart';
import 'create_post_screen.dart';
import '../user_ui/user_screen.dart';

class CommentsChatScreen extends StatefulWidget {
  // final UserModel otherUser;
  // final ChatModel? chat;
  final PostModel post;
  final bool isFullScreen;

  // final String chatId;

  const CommentsChatScreen(this.post, {this.isFullScreen = false, Key? key}) : super(key: key);

  @override
  State<CommentsChatScreen> createState() => _CommentsChatScreenState();
}

class _CommentsChatScreenState extends State<CommentsChatScreen> {
  var viewController = ScrollController();
  var sendController = TextEditingController();
  List<PostModel> comments = [];
  bool isInitMessages = true;

  // var splashLoader = true;
  // List<MessageModel> chatList = [];
  //

  @override
  void initState() {
    _loadOlderMessages();
    // .then((_) => comments.remove(comments.first)
    super.initState();
  }

  Future _loadOlderMessages() async {
    // splashLoader = true; setState(() {});
    List withOlderComments = await Database.advanced.handleGetModel(
        context, ModelTypes.posts, comments,
        filter: FilterTypes.sortByOldestComments,
        collectionReference: 'posts/${widget.post.id}/comments');
    if (withOlderComments.isNotEmpty) comments = [...withOlderComments];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: CommentsChatScreen()');
    var post = widget.post;

    return widget.isFullScreen
        ? Scaffold(
            backgroundColor: AppColors.primaryDark,
            body: buildScreenBody(post).pOnly(top: 40),
          )
        : Container(
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.only(topLeft: 15.circular, topRight: 15.circular),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.99),
                  offset: const Offset(0.0, 1.5), //(x,y)
                  blurRadius: 4.0,
                ),
              ],
            ),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 150),
            child: buildScreenBody(post),
          );
  }

  Widget buildScreenBody(PostModel post) {
    return Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        StreamBuilder<List<PostModel>>(
          //~ Comments works great but currently streamComments NOT connected!
          // Because comments load from the begging (1,2,3)
          // while chat need the end (10, 9, 8) theres no match to mix those
          // U can mix them by replace the comments to load from the end.
          // Use sample Ril conversion to handle it!
          stream: Database.streamComments(widget.post.id, limit: 1),
          initialData: const [],
          // builder: (context, child) {
          builder: (context, snapshot) {
            print('START: builder()');

            // if(snapshot.hasData && comments.isEmpty){
            //   comments = snapshot.data ?? [];
            // }

            // var newMsgs = context.listenCommentPostModelList;

            // if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            //   PostModel? newComment = snapshot.data?.first;
            //   _addLatestComment(newComment);
            // }

            return LazyLoadScrollView(
                scrollOffset: 300,
                onEndOfPage: () async {
                  print('START: COMMENTS onEndOfPage()');
                  // context.uniProvider.updateIsFeedLoading(true);
                  await _loadOlderMessages();
                  // context.uniProvider.updateIsFeedLoading(false);
                },
                child: ListView(
                  controller: viewController,
                  children: [
                    buildComment(post),
                    const Divider(thickness: 2.5, color: AppColors.chatBubble).px(10),
                    ListView.builder(
                        // controller: viewController,
                        // reverse: true,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        // controller: ,
                        itemCount: comments.length,
                        itemBuilder: (context, i) {
                          // I use manually reverse because reverse + LazyLoadScrollView()
                          // make issues while scrolling
                          // var revI = (comments.length - 1) - i;

                          // return FlutterLogo();
                          // return buildBubble(context, comments[i], (i + 1) == comments.length);
                          return buildComment(comments[i]);
                        }),
                  ],
                ).pOnly(bottom: 70, top: 50));
          },
        ),
        4.verticalSpace,

        //~ Title
        Container(
          color: AppColors.darkOutline,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Builder(builder: (context) {
            var commentsCount =
                '${comments.length}/${(post.commentsLength > comments.length ? post.commentsLength : comments.length)}';
            if (post.commentsLength == 0 && comments.isEmpty) commentsCount = 'New';
            var memberCount =
                post.commentedUsersIds.isEmpty ? 1 : post.commentedUsersIds.length + 1;
            return Row(
              children: [
                15.horizontalSpace,
                (commentsCount == 'New'
                        ? Assets.svg.icons.wisdomLightStar
                        : Assets.svg.icons.messageCommentsLines)
                    .svg(color: AppColors.grey50, height: 18),
                5.horizontalSpace,
                // '${(post.comments?.isEmpty ?? true) ? '' : post.comments?.length} members'
                commentsCount.toText(color: AppColors.grey50),
                20.horizontalSpace,
                Assets.svg.icons.groupMultiPeople.svg(color: AppColors.grey50, height: 14),
                ' $memberCount members'.toText(color: AppColors.grey50),
                // if (isTagScreen)
                //   '#$selectedTag'.toText(color: AppColors.darkOutline50).pOnly(left: 10, top: 10).centerLeft,
                const Spacer(),
                'Back'.toText(bold: true).pad(10).onTap(() {
                  Navigator.pop(context);
                }, radius: 5),
                20.horizontalSpace,
              ],
            );
          }),
        ).rounded(radius: 15),

        //~ TextField
        Container(
          color: AppColors.primaryDark,
          padding: const EdgeInsets.only(top: 5),
          child: StatefulBuilder(builder: (context, stfState) {
            return buildTextField(context,
                controller: sendController,
                stfSetState: stfState,
                hintText: 'Join ${post.creatorUser?.name}\'s conversion',
                // post: post,
                onTap: () async {
              UserModel currUser = context.uniProvider.currUser;
              var comment = PostModel(
                textContent: sendController.text,
                id: '${currUser.email}${UniqueKey()}',
                //  TODO ADD ON POST MVP ONLY: Use UID instead creatorUser so
                // details will be update if user edit his info
                creatorUser: currUser,
                timestamp: DateTime.now(),
                originalPostId: post.id,
                enableComments: true,
              );
              // context.uniProvider.updatePostUploaded(true);
              FeedService.addComment(context, comment, post);
              // viewController.jumpTo(0); // TOP
              comments.add(comment);
              setState(() {});
              // stfState(() {});
              viewController.jumpTo(viewController.position.maxScrollExtent + 150); // BOTTOM
              sendController.clear();
              // post = null;
            });
          }),
        ).bottom
      ],
    );
  }

  // void setInitMessages(List<PostModel> newMsgs) {
  //   print('START: setInitMessages()');
  //   comments = newMsgs;
  //   isInitMessages = false;
  //   // viewController.jumpTo(0);
  //   // _loadOlderMessages();
  // }

  void _addLatestComment(PostModel? newComment) {
    print('START: _addLatestComment()');
    isInitMessages = false;
    if (newComment != null && !(comments.contains(newComment))) {
      comments.insert(0, newComment);
      // comments.add(newComment);
      viewController.jumpTo(0);
      // viewController.jumpTo(viewController.position.maxScrollExtent + 150);
    }
  }

  ConstrainedBox buildReplyBubble(BuildContext context, bool currUser, MessageModel message) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.width * 0.8),
        // child: Bubble(
        child: Container(
            // elevation: 0,
            padding: const EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 6),
            margin: 5.horizontal,
            decoration: BoxDecoration(
                color: currUser ? AppColors.primaryLight : AppColors.darkOutline50,
                borderRadius: BorderRadius.only(
                  bottomRight: 3.circular,
                  topRight: (currUser ? 3 : 10).circular,
                  topLeft: (currUser ? 10 : 3).circular,
                  bottomLeft: 3.circular,
                )),
            // padding: const BubbleEdges.all(8.0),
            // nip: currUser ? BubbleNip.rightTop : BubbleNip.leftTop,
            // nipRadius: 0,
            // showNip: false,
            child: buildReplyProfile(
              context,
              message.postReply!,
              // actionButton: 'View Ril'.toText(medium: true).pad(13).onTap(() {
              //   TODO LATER LIST: Add View Ril Reply OnTap
              // }, radius: 10),
            )));
  }

  Builder buildComment(PostModel comment) {
    return Builder(builder: (context) {
      var postAgo = postTime(comment.timestamp!);
      var isCreatorComment = comment.creatorUser?.uid == widget.post.creatorUser?.uid;

      return Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('${comment.creatorUser!.photoUrl}'),
                backgroundColor: AppColors.darkOutline,
              ),
              buildOnlineBadge(),
            ],
          ).pad(4).onTap(() {
            print('PROFILE CLICKED');
            context.router.push(UserRoute(user: comment.creatorUser!));
          }),
          6.horizontalSpace,
          Builder(builder: (context) {
            var isHebComment = comment.textContent.isHebrew;
            return Container(
              color: isCreatorComment ? AppColors.primaryOriginal : AppColors.chatBubble,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment:
                    isHebComment ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isHebComment
                          ? postAgo.toText(color: AppColors.grey50, fontSize: 12)
                          : '${comment.creatorUser?.name}'
                              .toText(fontSize: 14, bold: true, color: AppColors.white),
                      10.horizontalSpace,
                      isHebComment
                          ? '${comment.creatorUser?.name}'
                              .toText(fontSize: 14, bold: true, color: AppColors.white)
                          : postAgo.toText(color: AppColors.grey50, fontSize: 12)
                    ],
                  ),
                  5.verticalSpace,
                  comment.textContent.toTextExpanded(
                      autoExpanded: true,
                      textAlign: isHebComment ? TextAlign.right : TextAlign.left,
                      style: AppStyles.text14PxRegular.copyWith(
                        color: AppColors.white,
                        fontSize: 14,
                      ))
                ],
              ),
            ).rounded(radius: 10).expanded();
          }),
        ],
      ).px(15).py(10);
    });
  }
}

Widget buildTextField(
  BuildContext context, {
  required TextEditingController controller,
  required StateSetter stfSetState,
  GestureTapCallback? onTap,
  PostModel? post,
  GestureTapCallback? postOnCloseReply,
  String? hintText,
}) {
  bool includeHeb = controller.text.isHebrew;

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // if (post != null) buildReplyField(post, onTap: postOnCloseReply),
      3.verticalSpace,
      TextField(
        // onTapOutside: (event) => setState(() => sendNode.unfocus()),
        autofocus: post != null,
        controller: controller,
        style: AppStyles.text16PxRegular.white,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        textAlign: controller.text.isEmpty
            ? TextAlign.start
            : includeHeb
                ? TextAlign.end
                : TextAlign.start,
        cursorColor: AppColors.white,
        onChanged: (val) => stfSetState(() {}),
        decoration: InputDecoration(
            filled: true,
            // fillColor: AppColors.primaryLight,
            // fillColor: AppColors.darkOutline50,
            // fillColor: AppColors.primaryLight2,
            fillColor: AppColors.chatBubble,
            hintStyle: AppStyles.text14PxRegular.greyLight,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            suffixIcon: buildSendButton(
              isActive:
                  controller.text.isNotEmpty && (controller.text.replaceAll(' ', '').isNotEmpty),
              onTap: onTap,
            )),
      )
          .roundedOnly(
            bottomLeft: 10,
            topLeft: post != null ? 3 : 10,
            topRight: post != null ? 3 : 10,
            bottomRight: 10,
          )
          .pOnly(bottom: 6),
    ],
  ).px(8);
}

Column buildReplyProfile(BuildContext context, PostModel post, {Widget? actionButton}) {
  var name = '${post.creatorUser?.name}';
  var shortName = name.length > 13 ? name.substring(0, 13) + '...'.toString() : name;
  var postAgo = postTime(post.timestamp!);
  return Column(
    children: [
      5.verticalSpace,
      Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('${post.creatorUser!.photoUrl}'),
                backgroundColor: AppColors.darkOutline,
              ),
              // buildOnlineBadge(),
            ],
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              shortName.toText(fontSize: 14, bold: true, color: AppColors.white, softWrap: false),
              postAgo
                  .toText(color: AppColors.grey50, fontSize: 11)
                  .pOnly(right: 10, top: 0, bottom: 0),
            ],
          ),
          // TODO ADD ON POST MVP ONLY (ago · Tag (Add Tags))
          const Spacer(),
          // .onTap(() {}, radius: 10), // TODO Add move to Tag
          // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
          actionButton ?? const Offstage()
          // 10.horizontalSpace,
        ],
      ),
      4.verticalSpace,
      buildExpandableText(
              // 'Example : let’s try to think of an topic or fdsk conte tou fc words as possible... I think I’ve already ',
              post.textContent,
              maxLines: 4,
              linkColor: AppColors.greyLight,
              textAlign: post.textContent.isHebrew ? TextAlign.right : TextAlign.left,
              textDirection: post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
              style: AppStyles.text14PxRegular.copyWith(color: AppColors.grey50))
          .advancedSizedBox(context, maxWidth: true)
          .pOnly(left: 50, bottom: 5, right: 45)
    ],
  );
}
