import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:formx_sdk_flutter/src/models/detect_mode.dart';
import 'package:formx_sdk_flutter/src/models/error.dart';
import 'package:formx_sdk_flutter/src/default_formx_camera_view_platform.dart';
import 'package:formx_sdk_flutter/src/formx_camera_view_android.dart';
import 'package:formx_sdk_flutter/src/formx_camera_view_ios.dart';
import 'package:formx_sdk_flutter/src/formx_camera_view_platform.dart';

/// A controller used to manipulate native formx camera view
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

/// A Flutter widget connected to native formx camera view
class FormXCameraView extends StatefulWidget {
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
  State<StatefulWidget> createState() {
    return FormXCameraViewState();
  }
}

class FormXCameraViewState extends State<FormXCameraView> {
  @override
  void dispose() {
    widget._controller.stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._controller.platform.buildWidget(
      detectMode: widget.detectMode,
      onClose: widget.onClose,
      onCaptureError: widget.onCaptureError,
      onCaptured: widget.onCaptured,
    );
  }
}
