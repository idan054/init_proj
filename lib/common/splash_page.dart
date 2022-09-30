import 'package:auto_route/auto_route.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

import 'mixins/after_layout_mixin.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayout {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 500),
      () => context.router.replaceAll([const LoginScreen()]),
    );
  }
}
