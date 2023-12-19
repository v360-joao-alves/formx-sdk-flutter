package ai.formx.mobile.sdk.formx_sdk_flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.launch

/** FormxSdkFlutterPlugin */
class FormxSdkFlutterPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "formx_sdk_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> {
                val formId = call.argument<String>("formId")
                val accessToken = call.argument<String>("accessToken")
                val endpoint = call.argument<String>("endpoint")
                if (formId != null && accessToken != null) {
                    try {
                        FormXSDKInitializer.init(formId, accessToken, endpoint)
                    } catch (e: Exception) {
                        result.error(runtimeError(e), e)
                        return
                    }
                    result.success(null)
                } else {
                    result.error(validationError("missing required parameters"))
                }
            }

            "detect" -> {
                val imagePath = call.argument<String>("imagePath")
                if (imagePath == null) {
                    result.error(validationError("missing required parameters"))
                    return
                }
                FormXSDKInitializer.apiClient?.let { apiClient ->
                    val imageBytes = ImageHelper.readBytes(imagePath)
                    CoroutineScope(Dispatchers.IO).launch {
                        apiClient.findDocuments(imageBytes).catch {
                            result.error(formXSDKError(it))
                        }.collect {
                            val r = it.toMap()
                            result.success(r)
                        }
                    }
                } ?: result.error(formXSDKNotInitialized())
            }

            "extract" -> {
                val imagePath = call.argument<String>("imagePath")
                if (imagePath == null) {
                    result.error(validationError("missing required parameters"))
                    return
                }
                FormXSDKInitializer.formId?.let { formId ->
                    FormXSDKInitializer.apiClient?.let { apiClient ->
                        val imageBytes = ImageHelper.readBytes(imagePath)
                        CoroutineScope(Dispatchers.IO).launch {
                            apiClient.extract(formId, imageBytes).catch {
                                result.error(formXSDKError(it))
                            }.collect {
                                val r = it.toMap()
                                result.success(r)
                            }
                        }
                    } ?: result.error(formXSDKNotInitialized())
                } ?: result.error(formXSDKNotInitialized())
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
