import 'package:formx_sdk_flutter/models/formx_detect_documents_result.dart';
import 'package:formx_sdk_flutter/models/formx_extraction_result.dart';

import 'formx_sdk_flutter_platform_interface.dart';

class FormxSdkFlutter {
  static Future<void> init(
      {required String formId, required String accessToken, String? endpoint}) {
    return FormxSdkFlutterPlatform.instance.init(formId, accessToken, endpoint);
  }

  static Future<FormXDetectDocumentsResult?> detect(String imagePath) {
    return FormxSdkFlutterPlatform.instance.detect(imagePath);
  }

  static Future<FormXExtractionResult?> extract(String imagePath) {
    return FormxSdkFlutterPlatform.instance.extract(imagePath);
  }

  static Future<bool?> isBlurry(String imagePath, double threshold) async {
    return FormxSdkFlutterPlatform.instance.isBlurry(imagePath, threshold);
  }
}
