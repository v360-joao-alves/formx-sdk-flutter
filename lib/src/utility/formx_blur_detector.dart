import 'package:formx_sdk_flutter/src/formx_sdk_flutter_platform_interface.dart';

/// A utility to detect if the image is blurry.
class FormxBlurDetector {
  FormxBlurDetector({this.threshold = 12});
  final double threshold;

  Future<bool?> isBlurry(String imagePath) {
    return FormxSdkFlutterPlatform.instance.isBlurry(imagePath, threshold);
  }
}
