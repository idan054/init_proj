import 'dart:ui';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Feed/feed_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/my_widgets.dart';
import 'main_feed_screen.dart';

class CreatePostScreen extends StatefulWidget {
  final bool replyStyle;
  final Function onChange;

  const CreatePostScreen(this.replyStyle, {required this.onChange, Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  var postController = TextEditingController();
  bool isComments = false;

  // bool isTagScreen = false;
  int? tagIndex;

  @override
  void initState() {
    // isTagScreen = context.uniProvider.selectedTag != 'New';

    isComments = !(widget.replyStyle); // no comments when reply mode!
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');
    print('isTagAdded $isComments');
    var textDir = postController.text.isHebrew ? TextDirection.rtl : TextDirection.ltr;
    // var selectedTag = context.uniProvider.selectedTag; // When filters in use

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkOutline,
        borderRadius: BorderRadius.only(topLeft: 15.circular, topRight: 15.circular),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.99),
            offset: const Offset(0.0, 1.5), //(x,y)
            blurRadius: 4.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (isTagScreen)
          //   '#$selectedTag'
          //       .toText(color: AppColors.darkOutline50)
          //       .pOnly(left: 10, top: 10)
          //       .centerLeft,
          TextField(
            maxLines: 11,
            minLines: 1,
            maxLength: isComments ? 512 : 256,
            // X2 for conversion
            buildCounter: (context, {required currentLength, required isFocused, maxLength}) =>
                postController.text.length == (isComments ? 512 : 256)
                    ? 'Max length'.toText(
                        fontSize: 12,
                        color: AppColors.errRed,
                      )
                    : const Offstage(),
            autofocus: true,
            textDirection: textDir,
            controller: postController,
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.multiline,
            style: AppStyles.text16PxRegular.copyWith(color: AppColors.white),
            onChanged: (val) => setState(() {}),
            // inputFormatters: [LengthLimitingTextInputFormatter(350)],
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              hintText: isComments ? 'Start a conversion about...' : 'Share your Ril thoughts...',
              hintStyle: AppStyles.text16PxRegular.copyWith(color: AppColors.grey50),
              fillColor: Colors.transparent,
              border: InputBorder.none,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildChoiceChip(context,
                      selectedColor: AppColors.primaryLight2,
                      customIcon: isComments
                          ? Assets.svg.icons.messageTextCircle02
                              .svg(height: 15, color: AppColors.primaryLight2)
                          : Assets.svg.icons.dmPlaneUntitledIcon
                              .svg(height: 15, color: AppColors.primaryLight2),
                      // label: (isComments ? 'With comments' : 'Reply style') // Reply only
                      label: (isComments ? 'With comments' : 'Reply only') // Reply only
                          .toText(color: isComments ? AppColors.primaryLight2 : AppColors.primaryLight2),
                      onSelect: (bool newSelection) {
                isComments = !isComments;
                widget.onChange(isComments);
                setState(() {});
              }, selected: isComments)
                  .centerLeft
                  .pOnly(left: 5),

              // Expanded(
              //   child: isTagAdded
              //       ? _tagsChoiceList(context)
              //       : buildChoiceChip(context, label: const Text('Add tag'),
              //               onSelect: (bool newSelection) {
              //           isTagAdded = !isTagAdded;
              //           setState(() {});
              //         }, selected: isTagAdded)
              //           .centerLeft
              //           .pOnly(left: 5),
              // ),

              const Spacer(),
              buildSendButton(
                  isActive: postController.text.isNotEmpty &&
                      (postController.text.replaceAll(' ', '').isNotEmpty),
                  withBg: true,
                  onTap: () {
                    UserModel currUser = context.uniProvider.currUser;
                    var post = PostModel(
                      textContent: postController.text,
                      id: '${currUser.email}${UniqueKey()}',
                      //  TODO ADD ON POST MVP ONLY: Use UID instead creatorUser so
                      // details will be update if user edit his info
                      creatorUser: currUser,
                      timestamp: DateTime.now(),
                      enableComments: isComments,
                      postType: isComments ? PostType.conversationRil : PostType.dmRil,
                      commentedUsersEmails: isComments ? [currUser.email.toString()] : [],
                    );
                    context.uniProvider.updatePostUploaded(true);
                    FeedService.uploadPost(context, post);
                    context.router.pop();
                  },
                  isConversationSend: isComments)
            ],
          ).pOnly(bottom: 5),
        ],
      ),
    );
  }

// SizedBox _tagsChoiceList(BuildContext context) {
//   return SizedBox(
//     height: 50.0,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: List<Widget>.generate(
//         tags.length,
//         (int i) {
//           var isChipSelected = tagIndex == i;
//
//           return buildChoiceChip(
//             context,
//             label: Text(tags[i]),
//             showCloseIcon: true,
//             selected: isChipSelected,
//             onSelect: (bool newSelection) {
//               if (newSelection) {
//                 tagIndex = i;
//               } else {
//                 tagIndex = null; // To do not remember selection.
//
//                 isTagAdded = false;
//               }
//               setState(() {});
//             },
//           );
//         },
//       ).toList(),
//     ),
//   );
// }
}

Widget buildSendButton(
    {GestureTapCallback? onTap, bool isActive = true, bool isConversationSend = false, bool withBg = false}) {
  return Opacity(
    opacity: isActive ? 1.0 : 0.3,
    child: Container(
      height: 37,
      width: 37,
      color: withBg ? AppColors.primaryOriginal : AppColors.transparent,
      // color: AppColors.primaryOriginal,
      // color: ,
      child: (isConversationSend
              ? Assets.svg.icons.messageChatCircleAdd.svg(color: Colors.white)
              : Assets.svg.icons.iconSendButton.svg())
          .pad(isConversationSend ? 8 : 9),
    )
        .roundedFull
        .px(10)
        .pOnly(top: 5, bottom: 5)
        .onTap(isActive ? onTap : null, radius: 10)
        .pOnly(right: 5),
  );
}

Widget quickCrossFade(bool value,
    {required Widget firstChild, required Widget secondChild, Duration? duration}) {
  return AnimatedCrossFade(
    duration: duration ?? 1.seconds,
    firstChild: firstChild,
    secondChild: secondChild,
    crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
