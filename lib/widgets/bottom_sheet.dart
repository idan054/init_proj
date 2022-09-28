import 'package:flutter/material.dart';

Future showAppBottomSheet(BuildContext context, Widget child,
    {AnimationController? animationController}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return child;
    },
    transitionAnimationController: animationController,
    isScrollControlled: true,
    useRootNavigator: true,
    isDismissible: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}
