import 'package:flutter/material.dart';

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
      body: Column(
        children: const [
          Spacer(),
        ],
      ),
    );
  }
}
