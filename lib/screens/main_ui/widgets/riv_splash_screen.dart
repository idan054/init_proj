import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

mixin SplashScreenStateMixin<T extends StatefulWidget> on State<T> implements TickerProvider {
  late Animation<double> animation, scaleAnimation;
  late AnimationController _animationController, _scaleAnimationController;
  late Animation<Color?> colorAnimation;
  bool animationCompleted = false;

  void _createAnimations() {
    _scaleAnimationController =
        AnimationController(vsync: this, value: 0, duration: 500.milliseconds);
    scaleAnimation = Tween(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeInOutBack,
    ));

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 1000,
        ));
    animation = Tween(
      begin: 0.0,
      end: 1000.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    colorAnimation = ColorTween(
      begin: AppColors.primaryDark,
      end: AppColors.transparent,
      // begin: Colors.grey[200],
      // end: Colors.grey[200],
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    colorAnimation = ColorTween(
      // begin: Color(0xff005FFF),
      begin: AppColors.primaryDark,
      end: Colors.transparent,
      // begin: Colors.white,
      // end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void forwardAnimations() {
    _scaleAnimationController.forward().whenComplete(() {
      _animationController.forward();
    });
  }

  Widget buildAnimation({bool showText = true, double ratio = 1, double radius = 999}) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                      alignment: Alignment.center,
                      // constraints: const BoxConstraints.expand(),
                      width: 170 * ratio,
                      height: 170 * ratio,
                      // color: colorAnimation.value,
                      color: AppColors.primaryOriginal,
                      // child: const RiveAnimation.asset('assets/riv/rilManBlackWhite.riv')
                      child: const RiveAnimation.asset('assets/riv/rilmanblackwhitefaster.riv')
                          .sizedBox(null, 150 * ratio).bottom
                          // .offset(0, 10)
              )
                  .rounded(radius: radius),
              30.verticalSpace,
              if(showText)'Riltopia'.toText(fontSize: 30)
            ],
          ).center,
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.scale(
                scale: animation.value,
                child: Container(
                  width: 1.0,
                  height: 1.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1 - _animationController.value),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ],
      );

  @override
  void initState() {
    _createAnimations();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationCompleted = true;
        });
      }
    });
    super.initState();
  }
}
