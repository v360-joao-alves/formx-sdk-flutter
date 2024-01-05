import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter/src/formx_sdk_flutter_platform_interface.dart';

class FormXSDK {
  /// Initialize FormX SDK with [formId] and [accessToken] retrieved from https://formextractorai.com.
  /// By default offical FormX api is used when [endpoint] is null.
  static Future<void> init(
      {required String formId, required String accessToken, String? endpoint}) {
    return FormxSdkFlutterPlatform.instance.init(formId, accessToken, endpoint);
  }

  /// Detect documents from given image
  static Future<FormXDetectDocumentsResult?> detect(String imagePath) {
    return FormxSdkFlutterPlatform.instance.detect(imagePath);
  }

  /// Extract document structures from given image
  static Future<FormXExtractionResult?> extract(String imagePath) {
    return FormxSdkFlutterPlatform.instance.extract(imagePath);
  }

  /// Check whether the given image is blurry
  static Future<bool?> isBlurry(String imagePath, double threshold) async {
    return FormxSdkFlutterPlatform.instance.isBlurry(imagePath, threshold);
  }
}
