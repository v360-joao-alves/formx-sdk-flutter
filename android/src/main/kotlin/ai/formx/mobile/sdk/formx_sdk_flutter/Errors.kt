package ai.formx.mobile.sdk.formx_sdk_flutter

import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

enum class ErrorCode {
    ValidationError,
    RuntimeExceptionError,
}

class Error(val code: ErrorCode, val message: String?)

fun validationError(message: String): Error {
    return Error(ErrorCode.ValidationError, message)
}

fun runtimeError(exception: Exception): Error {
    return Error(ErrorCode.RuntimeExceptionError, exception.message ?: "")
}


fun MethodChannel.Result.error(error: Error, details: Any? = null) {
    error(error.code.name, error.message ?: "", details)
}