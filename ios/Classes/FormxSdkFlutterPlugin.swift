import Flutter
import UIKit

public class FormxSdkFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "formx_sdk_flutter", binaryMessenger: registrar.messenger())
        let instance = FormxSdkFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            if let arguments = call.arguments as? Dictionary<String, Any>,
               let formId = arguments["formId"] as? String,
               let accessToken = arguments["accessToken"] as? String{
                let apiEndpoint = arguments["endpoint"] as? String
                FormXSDKInitializer.shared.`init`(formId: formId, accessToken: accessToken, apiHost: apiEndpoint)
                result(nil)
            } else {
                result(FormXError.validationError(message: "missing required parameters").asFlutterError())
            }
        case "detect":
            guard let arguments = call.arguments as? Dictionary<String, Any>,
                  let imagePath = arguments["imagePath"] as? String else {
                result(FormXError.validationError(message: "missing required parameters").asFlutterError())
                return
            }
            guard let formXApiClient = FormXSDKInitializer.shared.apiClient else {
                result(FormXError.formXSDKNotInitialized().asFlutterError())
                return
            }
            DispatchQueue.global().async {
                guard
                    let imageData = UIImage(contentsOfFile: URL(fileURLWithPath: imagePath).path)?.jpegData(
                        compressionQuality: 1) else {
                    DispatchQueue.main.async {
                        result(FormXError.invalidImagePath(imagePath: imagePath).asFlutterError())
                    }
                    return
                }
                formXApiClient.findDocuments(data: imageData) {response, error in
                    
                    DispatchQueue.main.async {
                        if let err = error {
                            result(FormXError.formXSDKError(err: err).asFlutterError())
                            return
                        }
                        guard let response = response else {
                            result(FormXError.emptyAPIResponse().asFlutterError())
                            return
                        }
                        result(response.toMap())
                    }
                }
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
