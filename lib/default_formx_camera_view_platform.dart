import 'package:flutter/widgets.dart';
import 'package:formx_sdk_flutter/formx_camera_view_platform.dart';
import 'package:formx_sdk_flutter/models/detect_mode.dart';
import 'package:formx_sdk_flutter/models/error.dart';

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
