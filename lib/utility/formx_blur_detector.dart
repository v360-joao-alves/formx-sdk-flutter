import 'package:formx_sdk_flutter/formx_sdk_flutter_platform_interface.dart';

class FormxBlurDetector {
  FormxBlurDetector({this.threshold = 12});
  final double threshold;

  Future<bool?> isBlurry(String imagePath) {
    return FormxSdkFlutterPlatform.instance.isBlurry(imagePath, threshold);
  }
}
