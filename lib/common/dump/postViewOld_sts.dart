// import 'package:example/common/extensions/extensions.dart';
// import 'package:example/common/routes/app_router.dart';
// import 'package:example/common/routes/app_router.gr.dart';
// import 'package:example/common/service/Chat/chat_services.dart';
// import 'package:example/common/service/Feed/feed_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../common/models/post/post_model.dart';
// import '../../common/service/mixins/assets.gen.dart';
// import '../../common/service/mixins/fonts.gen.dart';
// import '../../common/themes/app_colors.dart';
// import '../../common/themes/app_styles.dart';
// import '../../screens/main_ui/dashboard_screen.dart';
//
// class PostView extends StatelessWidget {
//   final PostModel post;
//
//   PostView(this.post, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double postRatio = 3;
//     // likeByIds.contains is the initial. (isLiked will change when click)
//     var isLiked = post.likeByIds.contains(context.uniProvider.currUser.uid);
//
//
//
//     TextAlign? postAlign; // Todo: Frontend so Hebrew will be only center || right Based .isHebrew
//     if (post.textAlign == 'right') postAlign = TextAlign.end;
//     if (post.textAlign == 'center') postAlign = TextAlign.center;
//     if (post.textAlign == 'right') postAlign = TextAlign.end;
//
//     return StatefulBuilder(builder: (context, setState) {
//       return GestureDetector(
//         // onDoubleTap: () {
//         //   FeedService().setPostLike(context, post, isLiked);
//         //   setState(() => isLiked = !isLiked);
//         // },
//         child: Stack(
//           children: [
//             Builder(builder: (context) {
//               bool isLongPost = post.textContent.length > 200;
//               return Container(
//                   height: 100 * postRatio,
//                   width: context.width,
//                   color: post.colorCover,
//                   child: Text(post.textContent,
//                           textAlign: postAlign,
//                           softWrap: true,
//                           maxLines: 15,
//                           style: AppStyles.text18PxBold.copyWith(
//                               fontSize: isLongPost ? 11 : 14,
//                               fontFamily: FontFamily.rilTopia,
//                               color: post.isDarkText ? AppColors.darkBlack : AppColors.white))
//                       .px(20)
//                       .pOnly(top: isLongPost ? 20 : 0)
//                       .center);
//             }),
//             buildTop(postRatio),
//             buildBottom(context, postRatio, isLiked).offset(0, 10),
//           ],
//         ),
//       );
//     });
//   }
//
//   Container buildTop(double postRatio) {
//     var postDiff = DateTime.now().difference(post.timestamp!);
//     var postAgo =
//         postDiff.inSeconds < 60 ? '${postDiff.inSeconds} sec' : '${postDiff.inMinutes} min';
//     return Container(
//       // color: AppColors.testGreen,
//       alignment: Alignment.topCenter,
//       height: 100 * postRatio,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//           stops: const [0.75, 0.99],
//           colors: [
//             AppColors.transparent,
//             AppColors.darkBlack.withOpacity(0.40),
//           ],
//         ),
//       ),
//       child: StatefulBuilder(builder: (context, stfSetState) {
//         return ListTile(
//           onTap: () {},
//           horizontalTitleGap: 0.0,
//           minVerticalPadding: 0.0,
//           contentPadding: const EdgeInsets.only(left: 10, right: 0),
//           trailing: Icons.more_vert.iconAwesome(size: 18).offset(0, -6).px(10).onTap(() {}),
//           leading: CircleAvatar(
//             radius: 18,
//             backgroundImage: NetworkImage('${post.creatorUser!.photoUrl}'),
//             backgroundColor: AppColors.darkBlack.withOpacity(0.33),
//           ).pOnly(right: 5),
//           title: post.creatorUser!.name!.toText(fontSize: 13, softWrap: true),
//           subtitle: Row(
//             children: [
//               '${post.creatorUser!.age}yrs  ·  $postAgo'
//                   // '${post.timestamp!.hour}:'
//                   //         '${post.timestamp!.minute.toString().length == 1 ? '0' : ''}'
//                   //         '${post.timestamp!.minute}'
//                   .toText(
//                       bold: true,
//                       fontSize: 10,
//                       color: post.isDarkText ? AppColors.greyUnavailable : AppColors.greyLight),
//               const Spacer(),
//             ],
//           ).pOnly(right: 10, top: 0).offset(0, -5),
//         ).offset(0, -5);
//       }),
//     );
//   }
//
//   Container buildBottom(BuildContext context, double postRatio, bool isLiked) {
//     var currUser = context.uniProvider.currUser;
//
//     return Container(
//         // color: AppColors.testGreen,
//         alignment: Alignment.bottomCenter,
//         height: 100 * postRatio,
//         //     stops: const [0.01, 0.25],
//         child: ListTile(
//             horizontalTitleGap: 0.0,
//             minVerticalPadding: 0.0,
//             contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//             // trailing:  FontAwesomeIcons.commentDots.iconAwesome(size: 18).pOnly(left: 5),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//
//                 Assets.svg.icons.commentUntitledIcon.svg(),
//                 // SvgPicture.asset('assets/svg/comment-untitled-icon.svg'),
//                 // Assets.svg.gLogoIcon.svg(height: 25),
//
//                 CircleAvatar(
//                     backgroundColor: AppColors.darkBlack.withOpacity(0.30),
//                     child: FontAwesomeIcons.solidPaperPlane.iconAwesome(size: 18).onTap(() {
//                       if (post.creatorUser!.uid == currUser.uid) {
//                         context.router.push(DashboardRoute(dashboardPage: TabItems.chat));
//                       } else {
//                         ChatService.openChat(context, otherUser: post.creatorUser!);
//                       }
//                     })),
//
//
//                 CircleAvatar(
//                     backgroundColor: AppColors.darkBlack.withOpacity(0.30),
//                     child: FontAwesomeIcons.share.iconAwesome(size: 18).onTap(() {
//                       print('Share Button Tapped!');
//                       //ToDO Use DeepLink to enable Share Button
//                     })),
//
//                 if (post.enableComments)
//                   CircleAvatar(
//                       backgroundColor: AppColors.darkBlack.withOpacity(0.30),
//                       child: FontAwesomeIcons.commentDots.iconAwesome(size: 18).onTap(() {})),
//               ],
//             )));
//   }
// }
