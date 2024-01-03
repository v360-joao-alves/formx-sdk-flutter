package ai.formx.mobile.sdk.formx_sdk_flutter

import ai.formx.mobile.sdk.camera.FormXCameraModeOffline
import ai.formx.mobile.sdk.camera.FormXCameraModeOnline
import ai.formx.mobile.sdk.camera.FormXCameraView
import ai.formx.mobile.sdk.camera.FormXCameraViewListener
import ai.formx.mobile.sdk.camera.FormXCameraViewState
import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.view.View
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.findViewTreeLifecycleOwner
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.setViewTreeLifecycleOwner
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.File
import java.io.FileOutputStream

class FormXCameraNativeViewFactory(
    private val activity: Activity,
    private val messenger: BinaryMessenger
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    internal class NativeView(
        activity: Activity,
        id: Int,
        private val creationParams: Map<String?, Any?>?,
        binaryMessenger: BinaryMessenger
    ) : PlatformView,

        MethodChannel.MethodCallHandler {
        companion object {
            const val JPEG_QUALITY = 75
        }

        private val view: FormXCameraView = FormXCameraView(activity)
        private val _channel = MethodChannel(binaryMessenger, "formx_sdk_flutter/camera_view#$id")

        init {
            _channel.setMethodCallHandler(this)
            view.also {
                it.setViewTreeLifecycleOwner(activity as LifecycleOwner)
                it.mode = when (creationParams?.getOrDefault("detectMode", "offline")) {
                    "offline" -> {
                        FormXCameraModeOffline()
                    }

                    else -> {
                        FormXSDKInitializer.apiClient?.let { apiClient ->
                            FormXCameraModeOnline(apiClient)
                        } ?: FormXCameraModeOffline()
                    }
                }
                it.isActive = true
                it.listener = object : FormXCameraViewListener {
                    override fun onCaptureImage(images: List<Bitmap>) {
                        it.isActive = false
                        val scope = it.findViewTreeLifecycleOwner()?.lifecycleScope
                        scope?.launch(Dispatchers.IO) {
                            val event = HashMap<String?, Any?>()
                            images.firstOrNull()?.let { image ->
                                val out = File.createTempFile("capturedImage", ".jpg")
                                FileOutputStream(out).use { stream ->
                                    image.compress(Bitmap.CompressFormat.JPEG, JPEG_QUALITY, stream)
                                }
                                event.apply {
                                    put("imageURI", out.absolutePath)
                                }
                            } ?: event.put("imageURI", null)

                            scope.launch(Dispatchers.Main) {
                                _channel.invokeMethod("onCaptured", event)
                            }
                        } ?: _channel.invokeMethod("onCaptured", HashMap<String?, Any?>().apply {
                            put("imageURI", null)
                        })
                    }

                    override fun onError(error: Throwable) {
                        _channel.invokeMethod("onCaptureError", HashMap<String, Any?>().apply {
                            put("error", formXSDKError(error).toMap())
                        })
                    }

                    override fun onStateChange(view: FormXCameraView) {
                        if (view.mode is FormXCameraModeOffline && view.state == FormXCameraViewState.READY) {
                            view.capture()
                        }
                    }

                    override fun onClose() {
                        _channel.invokeMethod("onClose", null)
                    }
                }
            }
        }

        override fun getView(): View {
            view.isActive = true
            return view
        }

        override fun dispose() {
            view.listener = null
            view.isActive = false
        }

        private fun capture() {
            view.capture()
        }

        private fun startCamera() {
            view.isActive = true
            if (view.mode is FormXCameraModeOffline) {
                view.mode = FormXCameraModeOffline()
            }
        }

        private fun stopCamera() {
            view.isActive = false
        }

        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
            when (call.method) {
                "capture" -> {
                    capture()
                    result.success(null)
                }

                "startCamera" -> {
                    startCamera()
                    result.success(null)
                }

                "stopCamera" -> {
                    stopCamera()
                    result.success(null)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return NativeView(activity, viewId, args as? Map<String?, Any?>, messenger)
    }
}