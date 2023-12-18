import 'formx_sdk_flutter_platform_interface.dart';

class FormxSdkFlutter {
  Future<void> init(
      {required String formId, required String accessToken, String? endpoint}) {
    return FormxSdkFlutterPlatform.instance.init(formId, accessToken, endpoint);
  }
}
