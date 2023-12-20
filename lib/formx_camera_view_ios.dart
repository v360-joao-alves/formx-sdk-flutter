import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:formx_sdk_flutter/formx_camera_view_platform.dart';
import 'package:formx_sdk_flutter/models/detect_mode.dart';
import 'package:formx_sdk_flutter/models/error.dart';

class FormXCameraViewIOS extends FormXCameraViewPlatform {
  VoidCallback? _onClose;
  Function(Uri imagePath)? _onCaptured;
  Function(FormXCameraViewError error)? _onCaptureError;

  @override
  void onClose() {
    _onClose?.call();
  }

  @override
  void onCaptured(String imagePath) {
    _onCaptured?.call(Uri.parse(imagePath));
  }

  @override
  void onCaptureError(FormXCameraViewError error) {
    _onCaptureError?.call(error);
  }

  @override
  Widget buildWidget(
      {Key? key,
      VoidCallback? onClose,
      Function(Uri imagePath)? onCaptured,
      Function(FormXCameraViewError)? onCaptureError,
      required DetectMode detectMode}) {
    _onClose = onClose;
    _onCaptured = onCaptured;
    _onCaptureError = onCaptureError;
    return UiKitView(
      key: key,
      viewType: "formx_sdk_flutter/camera_view_ios",
      onPlatformViewCreated: init,
      creationParams: <String, dynamic>{
        "detectMode": detectMode.name,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
