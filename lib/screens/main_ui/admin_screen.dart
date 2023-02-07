// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/report/report_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:flutter/material.dart';
import '../../common/extensions/color_printer.dart';
import '../../common/models/post/post_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/themes/app_styles.dart';
import 'dart:io' show Platform;

import '../../widgets/components/feed/buildFeed.dart';
import '../../widgets/components/postBlock_stf.dart';
import '../../widgets/components/reported_user_block.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with SingleTickerProviderStateMixin {
  final _pageController = PageController(initialPage: 0);
  TabController? _tabController;
  bool splashLoader = true;
  List<ReportModel> reportList = [];
  var activeFilter = FilterTypes.reportedRils;

  FeedTypes? comeFromFeed;
  @override
  void initState() {
    super.initState();
    comeFromFeed = context.uniProvider.feedType;
    _tabController = TabController(vsync: this, length: 2);
    _loadMore();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future _loadMore({bool refresh = false}) async {
    print('START: ADMIN _loadMore()');

    if (refresh) {
      splashLoader = true;
      reportList = [];
      setState(() {});
    }

    var isRilReport = activeFilter == FilterTypes.reportedRils;
    List newPosts = await Database.advanced.handleGetModel(
      context,
      ModelTypes.reports,
      reportList,
      filter: activeFilter, // Rils / users
      collectionReference:
          isRilReport ? 'reports/Reported rils/rils' : 'reports/Reported users/users',
    );
    if (newPosts.isNotEmpty) reportList = [...newPosts];
    print('newPosts Admin ${newPosts.length}');
    splashLoader = false;

    // Temp fix
    setState(() {});
    // Future.delayed(350.milliseconds).then((_) => setState(() {}));
    // Future.delayed(350.milliseconds).then((_) => setState(() {}));
  }

  void _handleIndexChanged(int i, {required bool fromTabBar}) async {
    print('START: _handleIndexChanged()');
    if (fromTabBar) {
      _pageController.animateToPage(i, duration: 250.milliseconds, curve: Curves.easeIn);
    } else {
      _tabController?.animateTo(i);
    }
    // _pageController.jumpToPage(i);
    // if (mounted) setState(() {});

    if (i == 0) {
      activeFilter = FilterTypes.reportedRils;
    }
    if (i == 1) {
      activeFilter = FilterTypes.postWithComments;
    }
    context.uniProvider.currFilterUpdate(activeFilter);
    await _loadMore(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    print('START: AdminScreen()');

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        appBar: buildRiltopiaAppBar(
          context,
          isHomePage: false,
          bottom: TabBar(
            // isScrollable: true,
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                borderSide: const BorderSide(width: 2.5, color: AppColors.errRed),
                insets: 30.horizontal),
            labelStyle: AppStyles.text14PxRegular,
            indicatorColor: AppColors.primaryOriginal,
            tabs: const [
              Tab(text: 'Rils & Comments'),
              Tab(text: 'Users'),
            ],
            onTap: (i) async => _handleIndexChanged(i, fromTabBar: true),
          ),
        ),
        body: PageView(
            controller: _pageController,
            physics: const ScrollPhysics(),
            // physics: const NeverScrollableScrollPhysics(), // disable swipe
            onPageChanged: (i) => _handleIndexChanged(i, fromTabBar: false),
            children: <Widget>[
              Builder(builder: (context) {
                var postList = <PostModel>[];
                for (var rep in reportList) {
                  if (rep.reportedPost != null) postList.add(rep.reportedPost!);
                }

                printWhite('postList.length: ${postList.length}');
                printWhite('reportList.length: ${reportList.length}');

                return buildFeed(
                  desc: 'NEW REPORTED RILS & COMMENTS',
                  context,
                  postList,
                  splashLoader,
                  reportList: reportList,
                  feedType: FeedTypes.reports,
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
              Builder(builder: (context) {
                var postList = <PostModel>[];
                for (var rep in reportList) {
                  if (rep.reportedUser != null) postList.add(const PostModel());
                }

                printWhite('postList.length: ${postList.length}');
                printWhite('reportList.length: ${reportList.length}');

                return buildFeed(
                  desc: 'NEW USERS REPORTS',
                  context,
                  postList,
                  splashLoader,
                  reportList: reportList,
                  feedType: FeedTypes.reports,
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
            ]),
      ),
    );
  }
}

Widget buildReportBlock(ReportModel report, bool isComment) {
  String reportByTitle = '';
  reportByTitle += report.reportedUser != null ? 'User ' : (isComment ? 'Comment ' : 'Ril ');
  reportByTitle += 'Reported by ${report.reportedBy} ';
  reportByTitle += '(${report.reportStatus?.name}) ';

  return Column(
    children: [
      const Divider(thickness: 2, color: AppColors.darkOutline),
      reportByTitle
          .toText(color: Colors.white30, fontSize: 12)
          .centerLeft
          .pOnly(top: 5, left: 15)
          .pad(3)
          .onTap(() {}, radius: 5),
      // if (isComment)
      //   'Go to original Ril (unavailable)'
      //       .toText(color: Colors.white30, fontSize: 12)
      //       .centerLeft
      //       .pOnly(left: 15)
      //       .pad(3)
      //       .onTap(() {}, radius: 5),
      report.reportedUser != null
          ? ReportedUserBlock(report)
          : PostBlock(report.reportedPost!, isReported: true)
    ],
  );
}
