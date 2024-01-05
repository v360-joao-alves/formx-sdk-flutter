import 'package:flutter/widgets.dart';
import 'package:formx_sdk_flutter/src/models/detect_mode.dart';
import 'package:formx_sdk_flutter/src/models/error.dart';
import 'package:formx_sdk_flutter/src/formx_camera_view_platform.dart';

class DefaultFormXCameraViewPlatform extends FormXCameraViewPlatform {
  @override
  Widget buildWidget(
      {Key? key,
      VoidCallback? onClose,
      Function(Uri imagePath)? onCaptured,
      Function(FormXCameraViewError errorData)? onCaptureError,
      required DetectMode detectMode}) {
    return const Text("unimplemented");
  }
}
