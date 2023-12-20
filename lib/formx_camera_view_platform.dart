import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:formx_sdk_flutter/default_formx_camera_view_platform.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter_platform_interface.dart';
import 'package:formx_sdk_flutter/models/detect_mode.dart';
import 'package:formx_sdk_flutter/models/error.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FormXCameraViewPlatform extends PlatformInterface {
  FormXCameraViewPlatform() : super(token: _token);

  static final Object _token = Object();

  static FormXCameraViewPlatform _instance = DefaultFormXCameraViewPlatform();

  /// The default instance of [FormxSdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelFormxSdkFlutter].
  static FormXCameraViewPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FormXCameraViewPlatform] when
  /// they register themselves.
  static set instance(FormXCameraViewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  @visibleForTesting
  late MethodChannel methodChannel;

  _handleMethodCall(MethodCall call, int viewId) {
    switch (call.method) {
      case "onCaptured":
        onCaptured(call.arguments["imageURI"]);
        break;
      case "onCaptureError":
        onCaptureError(FormXCameraViewError(call.arguments["error"]));
        break;
      case "onClose":
        onClose();
        break;
    }
  }

  void onCaptured(String imagePath) {
    throw UnimplementedError('onCaptured() has not been implemetned.');
  }

  void onCaptureError(FormXCameraViewError error) {
    throw UnimplementedError('onCaptureError() has not been implemetned.');
  }

  void onClose() {
    throw UnimplementedError('onClose() has not been implemetned.');
  }

  /// /// Initializes the platform interface with [id].
  ///
  /// This method is called when the plugin is first initialized.
  Future<void> init(int viewId) async {
    methodChannel = MethodChannel('formx_sdk_flutter/camera_view#$viewId');
    methodChannel.setMethodCallHandler(
        (MethodCall call) => _handleMethodCall(call, viewId));
  }

  Future<void> capture() {
    return methodChannel.invokeMethod("capture");
  }

  Future<void> startCamera() {
    return methodChannel.invokeMethod("startCamera");
  }

  Future<void> stopCamera() {
    return methodChannel.invokeMethod("stopCamera");
  }

  Widget buildWidget({
    Key? key,
    VoidCallback? onClose,
    Function(Uri imagePath)? onCaptured,
    Function(FormXCameraViewError error)? onCaptureError,
    required DetectMode detectMode,
  }) {
    throw UnimplementedError('buildWidget() has not been implemented.');
  }
}
