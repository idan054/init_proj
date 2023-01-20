import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';

// import 'package:example/common/service/Auth/firebase_database.dart';
import 'package:example/widgets/components/postViewOld_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import '../../common/extensions/color_printer.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/universalModel.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/components/postBlock_sts.dart';

// Todo: Add ranks
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
  'Fashion',
];

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  var newTags = ['New', ...tags];
  var feedController = PageController();
  var chipsController = ScrollController();
  List<PostModel> postList = [];
  var splashLoader = true;
  int tagIndex = 0;

  @override
  void initState() {
    print('START: initState()');
    _loadMore();
    super.initState();
  }

  Future _loadMore({bool refresh = false}) async {
    print('START: _loadMore()');

    // splashLoader = true; setState(() {});
    if (refresh) postList = [];
    List newPosts = await Database.advanced.handleGetModel(ModelTypes.posts, postList);
    if (newPosts.isNotEmpty) postList = [...newPosts];
    splashLoader = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen() ${context.routeData.path}');
    var postUploaded = context.listenUniProvider.postUploaded;
    if (postUploaded) {
      _loadMore(refresh: true);
      context.uniProvider.postUploaded = false;
      // context.uniProvider.updatePostUploaded(false); // Will rebuild
    }

    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
          backgroundColor: AppColors.darkBg,
          appBar: buildRiltopiaAppBar(
            context,
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: const BorderSide(width: 2.5, color: AppColors.primaryOriginal),
                  insets: 30.horizontal),
              labelStyle: AppStyles.text14PxRegular,
              indicatorColor: AppColors.primaryOriginal,
              tabs: const [
                Tab(text: 'Latest'),
                Tab(text: 'Questions'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildFeed(context),
              buildFeed(context),
            ],
          )),
    );
  }

  Widget buildFeed(BuildContext context) {
    return LazyLoadScrollView(
      scrollOffset: 1500,
      onEndOfPage: () async {
        printGreen('START: main_feed_screen.dart onEndOfPage()');
        // context.uniProvider.updateIsLoading(true);
        await _loadMore();
        // context.uniProvider.updateIsLoading(false);
      },
      child: Builder(builder: (context) {
        // return 'Sorry, no post found... \nTry again later!'.toText().center;

        if (splashLoader || postList.isEmpty) {
          // First time only
          return const CircularProgressIndicator(color: AppColors.primaryOriginal, strokeWidth: 7)
              .center;
        }

        return RefreshIndicator(
            backgroundColor: AppColors.darkGrey,
            color: AppColors.primaryOriginal,
            onRefresh: () async {
              print('START: onRefresh()');
              await _loadMore(refresh: true);
            },
            child: ListView(
              children: [
                buildTagTitle(),
                2.verticalSpace,
                //   Expanded(child:
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: postList.length,
                  itemBuilder: (BuildContext context, int i) =>
                      // PostView(postList[i])
                      PostBlock(postList[i]),
                ),
                //     )
              ],
            ));
      }),
    );
  }

  ListTile buildTagTitle() {
    bool isNewTag = newTags[tagIndex] == 'New';

    return ListTile(
      minVerticalPadding: 25,
      tileColor: AppColors.primaryDark,
      // horizontalTitleGap: 0,
      // leading: Assets.svg.icons.shieldTickUntitledIcon.svg(),
      title: Row(
        children: [
          if (isNewTag) ...[
            Assets.svg.icons.shieldTickUntitledIcon.svg(color: Colors.white70),
            const SizedBox(width: 5),
          ],
          (isNewTag ? 'EXPLORE 14-17 Y.O MEMBERS' : 'MEMBERS WHO INTERESTED IN')
              .toText(fontSize: 13, color: AppColors.grey50)
              .pOnly(top: 3)
        ],
      ).pOnly(bottom: 15),
      subtitle: newTags[tagIndex].toUpperCase().toText(fontSize: 18, medium: true).appearAll,
    );
  }

  AppBar buildRiltopiaAppBar(BuildContext context, {PreferredSizeWidget? bottom}) {
    return AppBar(
      elevation: 2,
      backgroundColor: AppColors.primaryDark,
      title: riltopiaHorizontalLogo(ratio: 1.15),
      actions: [
        CircleAvatar(
          backgroundColor: AppColors.primaryDark,
          child: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(context.uniProvider.currUser.photoUrl!),
            backgroundColor: AppColors.darkOutline50,
          ),
        ).px(10).py(5).onTap(() {
          context.router.push(UserRoute(user: context.uniProvider.currUser));
        })
      ],

      // TODO ADD ON POST MVP ONLY (Notification page)
      // actions: [Assets.svg.icons.bellUntitledIcon.svg().px(20).onTap(() {})],

      bottom: bottom,
      // TODO ADD ON POST MVP ONLY (Tags Row)
      // bottom: PreferredSize(
      //   preferredSize: const Size(00.0, 50.0),
      //   child: Card(
      //     elevation: 0,
      //     color: AppColors.primaryDark,
      //     child: _feedChoiceList(context),
      //   ),
      // ),
    );
  }

  SizedBox _feedChoiceList(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView(
        controller: chipsController,
        scrollDirection: Axis.horizontal,
        children: List<Widget>.generate(
          newTags.length,
          (int i) {
            var isChipSelected = tagIndex == i;

            return buildChoiceChip(
              context,
              label: Text(newTags[i]),
              selected: isChipSelected,
              onSelect: (bool newSelection) {
                if (newSelection) tagIndex = i;
                context.uniProvider.updateSelectedTag(newTags[i]);
                feedController.jumpToPage(tagIndex);
                // feedController.animateToPage(selectedTag!, duration: 250.milliseconds, curve: Curves.easeIn);
                setState(() {});
              },
            );
          },
        ).toList(),
      ),
    );
  }
}

Widget buildChoiceChip(BuildContext context,
    {bool showCloseIcon = false,
    Widget? customIcon,
    Color? selectedColor,
    double? padding,
    bool isUnselectedBorder = true,
    required bool selected,
    ValueChanged<bool>? onSelect,
    required Widget label}) {
  return Padding(
    padding: (padding ?? 6).horizontal,
    child: Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: 10.roundedShape,
          selected: selected,
          materialTapTargetSize: (padding != null) ? MaterialTapTargetSize.shrinkWrap : null,
          padding: (padding != null) ? 0.all : null,
          backgroundColor: AppColors.darkOutline,
          selectedColor: selectedColor ?? AppColors.white,
          side: !isUnselectedBorder
              ? null
              : BorderSide(
                  width: 1.5,
                  color: selectedColor ?? (selected ? AppColors.white : AppColors.grey50)),
          // side: BorderSide.none,
          labelStyle: AppStyles.text14PxRegular.copyWith(
              color: selected ? AppColors.primaryDark : AppColors.white,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              // fontWeight: FontWeight.bold,
              fontSize: 12),
          label: label,
          // disabledColor: selected ? AppColors.primaryDark : AppColors.primaryDark,
          avatar: customIcon ??
              (showCloseIcon && selected
                  ? Assets.svg.icons.iconClose.svg(color: AppColors.primaryDark)
                  : null),
          onSelected: onSelect),
    ),
  );
}
