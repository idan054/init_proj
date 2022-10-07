import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../common/themes/app_colors.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: MainFeedScreen()');

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Column(
        children: [Icons.home.icon().center],
      ),
    );
  }
}
