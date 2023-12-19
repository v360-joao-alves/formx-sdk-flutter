package ai.formx.mobile.sdk.formx_sdk_flutter

import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

enum class ErrorCode {
    ValidationError,
    RuntimeExceptionError,
    FormXSDKError,
}

class Error(val code: ErrorCode, val message: String?, details: Any? = null)

fun validationError(message: String): Error {
    return Error(ErrorCode.ValidationError, message)
}

fun runtimeError(exception: Exception): Error {
    return Error(ErrorCode.RuntimeExceptionError, exception.message ?: "", exception)
}

fun formXSDKNotInitialized(): Error{
    return Error(ErrorCode.FormXSDKError, "formx sdk is not initialized")
}
fun invalidImagePath(imagePath: String): Error {
    return Error(ErrorCode.FormXSDKError, "failed to read image from $imagePath")
}
fun formXSDKError(exception: Exception) : Error {
    return Error(ErrorCode.FormXSDKError, exception.message ?: "", exception)
}
fun formXSDKError(throwable: Throwable) : Error {
    return Error(ErrorCode.FormXSDKError, throwable.message ?: "", throwable)
}
fun emptyAPIResponse(): Error{
    return Error(ErrorCode.FormXSDKError, "empty response")
}

fun MethodChannel.Result.error(error: Error, details: Any? = null) {
    error(error.code.name, error.message ?: "", details)
}