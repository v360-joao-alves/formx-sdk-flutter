import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'formx_sdk_flutter_platform_interface.dart';

/// An implementation of [FormxSdkFlutterPlatform] that uses method channels.
class MethodChannelFormxSdkFlutter extends FormxSdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('formx_sdk_flutter');

  @override
  Future<void> init(String formId, String accessToken, String? endpoint) {
    return methodChannel.invokeMethod<String>(
        'init',
        Map.of({
          "formId": formId,
          "accessToken": accessToken,
          "endpoint": endpoint
        }));
  }
}
