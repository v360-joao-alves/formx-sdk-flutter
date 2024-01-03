/// Common error message from FormX CameraView
class FormXCameraViewError extends Error {
  final String code;
  final String message;

  FormXCameraViewError(Map<Object?, Object?> data)
      : code = data["code"] as String,
        message = data["message"] as String;
}
