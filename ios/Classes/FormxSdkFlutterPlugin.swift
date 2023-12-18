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
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
