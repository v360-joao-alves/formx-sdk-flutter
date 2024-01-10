import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';

/// Error threw by [FormXCameraView]
class FormXCameraViewError extends Error {
  final String code;
  final String message;

  FormXCameraViewError(Map<Object?, Object?> data)
      : code = data["code"] as String,
        message = data["message"] as String;
}
