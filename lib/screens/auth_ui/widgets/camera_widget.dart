import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  final CameraController cameraController;

  const CameraWidget(this.cameraController, {Key? key}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  void dispose() {
    // widget.cameraController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var cameraController = widget.cameraController;

    return Container(
        color: AppColors.darkOutline,
        child: cameraController.value.isInitialized
            ? CameraPreview(cameraController)
            : const CircularProgressIndicator(color: AppColors.grey50, strokeWidth: 5).center);
  }
}
