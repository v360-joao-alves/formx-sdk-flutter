class FormXCameraViewError extends Error {
  final String code;
  final String message;

  FormXCameraViewError(Map<String, dynamic> data)
      : code = data["code"] as String,
        message = data["message"] as String;
}
