import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:formx_sdk_flutter/default_formx_camera_view_platform.dart';
import 'package:formx_sdk_flutter/formx_camera_view_android.dart';
import 'package:formx_sdk_flutter/formx_camera_view_ios.dart';
import 'package:formx_sdk_flutter/formx_camera_view_platform.dart';
import 'package:formx_sdk_flutter/models/detect_mode.dart';
import 'package:formx_sdk_flutter/models/error.dart';

class FormXCameraController {
  final FormXCameraViewPlatform platform;
  FormXCameraController()
      : platform = defaultTargetPlatform == TargetPlatform.iOS
            ? FormXCameraViewIOS()
            : defaultTargetPlatform == TargetPlatform.android
                ? FormXCameraViewAndroid()
                : DefaultFormXCameraViewPlatform();
  void startCamera() {
    platform.startCamera();
  }

  void stopCamera() {
    platform.stopCamera();
  }

  void capture() {
    platform.capture();
  }
}

class FormXCameraView extends StatelessWidget {
  FormXCameraView({
    super.key,
    this.detectMode = DetectMode.offline,
    this.onCaptured,
    this.onCaptureError,
    this.onClose,
    FormXCameraController? controller,
  }) : _controller = controller ?? FormXCameraController();

  final void Function(Uri imagePath)? onCaptured;
  final void Function(FormXCameraViewError error)? onCaptureError;
  final VoidCallback? onClose;
  final DetectMode detectMode;
  final FormXCameraController _controller;

  @override
  Widget build(BuildContext context) {
    return _controller.platform.buildWidget(
      detectMode: detectMode,
      onClose: onClose,
      onCaptureError: onCaptureError,
      onCaptured: onCaptured,
    );
  }
}
