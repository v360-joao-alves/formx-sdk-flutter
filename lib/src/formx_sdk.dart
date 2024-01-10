import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter/src/formx_sdk_flutter_platform_interface.dart';

// A SDK wrapper to communicate with the FormX API
class FormXSDK {
  /// Setup SDK with [formId] and [accessToken]. if [endpoint] is null, official formx api endpoint is used.
  static Future<void> init(
      {required String formId, required String accessToken, String? endpoint}) {
    return FormxSdkFlutterPlatform.instance.init(formId, accessToken, endpoint);
  }

  /// Detect documents by FormX API
  static Future<FormXDetectDocumentsResult?> detect(String imagePath) {
    return FormxSdkFlutterPlatform.instance.detect(imagePath);
  }

  /// Extract form data from documents by FormX API
  static Future<FormXExtractionResult?> extract(String imagePath) {
    return FormxSdkFlutterPlatform.instance.extract(imagePath);
  }
}
