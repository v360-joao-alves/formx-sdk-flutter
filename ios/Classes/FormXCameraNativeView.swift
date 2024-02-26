//
//  FormXCameraNativeView.swift
//  formx_sdk_flutter
//
//  Created by wu mark on 2023/12/20.
//

import Foundation
import Flutter
import FormX

class FormXCameraNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FormXCameraNativeView(
            frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FormXCameraNativeView: NSObject, FlutterPlatformView, FormXCameraViewDelegate {
    private var messenger: FlutterBinaryMessenger
    private var args: Any?
    private weak var cameraView: FormXCameraView?
    private let _channel: FlutterMethodChannel
    
    init(frame: CGRect,
         viewIdentifier viewId: Int64,
         arguments args: Any?,
         binaryMessenger messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        self.args = args
        _channel = FlutterMethodChannel(name: "formx_sdk_flutter/camera_view#\(viewId)", binaryMessenger: messenger)
        super.init()
        _channel.setMethodCallHandler { [weak self] call, result in
            self?.handle(call, result: result)
        }
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "capture":
            capture()
            result(nil)
        case "startCamera":
            startCamera()
            result(nil)
        case "stopCamera":
            stopCamera()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func view() -> UIView {
        let formXCameraView = FormXCameraView()
        if let args = args as? Dictionary<String, Any> {
            if let detectMode = args["detectMode"] as? String {
                if detectMode == "online", let apiClient = FormXSDKInitializer.shared.apiClient {
                    formXCameraView.mode = .online(api: apiClient)
                } else {
                    formXCameraView.mode = .offline
                }
            }
        }
        formXCameraView.start()
        formXCameraView.delegate = self
        cameraView = formXCameraView
        return formXCameraView
    }
    
    func capture() {
        cameraView?.capture()
    }
    
    func startCamera() {
        cameraView?.start()
    }
    
    func stopCamera() {
        cameraView?.stop()
    }
    
    func onCaptured(_ imageURI: URL) {
        DispatchQueue.main.async {
            self._channel.invokeMethod("onCaptured", arguments: ["imageURI": imageURI.absoluteString])
        }
    }
    
    func onCaptureError(_ error: Error?) {

    }
    
    func formXCameraView(didCapture images: [CGImage]) {
        guard let capturedImage = images.first else {
            onCaptureError(nil)
            return
        }
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let imageURI = FileManager.default.temporaryDirectory.appendingPathComponent(
            "capturedImage\(timestamp).jpg")
        do {
            try UIImage(cgImage: capturedImage)
                .jpegData(compressionQuality: 1)?.write(to: imageURI)
            onCaptured(imageURI)
            stopCamera()
        } catch {
            onCaptureError(nil)
        }
    }
    
    func formXCameraView(didChangeState view: FormX.FormXCameraView) {
        if case .offline = view.mode,
           view.state == .ready
        {
            capture()
        }
    }
    
    func formXCameraView(didFailed error: Error) {
    }
    
    func formXCameraView(didRequestClose view: FormX.FormXCameraView) {
        DispatchQueue.main.async {
            self._channel.invokeMethod("onClose", arguments: nil)
        }
    }
}
