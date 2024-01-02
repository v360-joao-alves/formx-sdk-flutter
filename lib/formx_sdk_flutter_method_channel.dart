import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:formx_sdk_flutter/models/formx_detect_documents_result.dart';
import 'package:formx_sdk_flutter/models/formx_extraction_result.dart';

import 'formx_sdk_flutter_platform_interface.dart';

/// An implementation of [FormxSdkFlutterPlatform] that uses method channels.
class MethodChannelFormxSdkFlutter extends FormxSdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('formx_sdk_flutter');

  @override
  Future<void> init(String formId, String accessToken, String? endpoint) {
    return methodChannel.invokeMethod<void>(
        'init',
        Map.of({
          "formId": formId,
          "accessToken": accessToken,
          "endpoint": endpoint
        }));
  }

  @override
  Future<FormXDetectDocumentsResult?> detect(String imagePath) async {
    final r = await methodChannel.invokeMethod<Map<Object?, Object?>>(
        'detect',
        Map.of({
          "imagePath": imagePath,
        }));
    if (r != null) {
      return FormXDetectDocumentsResult(r);
    }
    return null;
  }

  @override
  Future<FormXExtractionResult?> extract(String imagePath) async {
    final r = await methodChannel.invokeMethod<Map<Object?, Object?>>(
        'extract',
        Map.of({
          "imagePath": imagePath,
        }));
    if (r != null) {
      return FormXExtractionResult(r);
    }
    return null;
  }

  @override
  Future<bool?> isBlurry(String imagePath, double threshold) async {
    final r = await methodChannel.invokeMethod<bool>(
        'isBlurry',
        Map.of({
          "imagePath": imagePath,
          "threshold": threshold,
        }));
    if (r != null) {
      return r;
    }
    return null;
  }
}
