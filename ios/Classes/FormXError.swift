//
//  FormXError.swift
//  formx_sdk_flutter
//
//  Created by wu mark on 2023/12/18.
//

import Foundation
import Flutter
import FormX

enum ErrorCode: String {
    case ValidationError
    case RuntimeError
    case FormXSDKError
}

class FormXError {
    
    static func validationError(message: String) -> FormXError {
        return FormXError(code: ErrorCode.ValidationError, message: message)
    }
    static func formXSDKNotInitialized() -> FormXError {
        return FormXError(code: .FormXSDKError, message: "formx sdk is not initialized")
    }
    static func invalidImagePath(imagePath: String) -> FormXError {
        return FormXError(code: .FormXSDKError, message: "failed to read image from \(imagePath)")
    }
    static func formXSDKError(err: Error) -> FormXError {
        let errMsg: String?
        if case FormXAPIClientError.decodeError = err {
            errMsg = FormXAPIClientError.decodeError .localizedDescription
        } else if case FormXAPIClientError.detectDocumentsServerError(response: let response) = err {
            errMsg = response.error.message
        } else if case FormXAPIClientError.extractServerError(response: let response) = err {
            errMsg = response.error.message
        } else {
            errMsg = nil
        }
        return FormXError(code: .FormXSDKError, message: errMsg ?? err.localizedDescription)
    }
    static func emptyAPIResponse() -> FormXError {
        return FormXError(code: .FormXSDKError, message: "empty response")
    }
    
    let code: String
    let message: String
    let details: Any?
    init(code: ErrorCode, message: String, details: Any? = nil) {
        self.code = code.rawValue
        self.message = message
        self.details = details
    }
    
    func asFlutterError() -> FlutterError {
        return FlutterError(code: self.code, message: self.message, details: self.details)
    }
}
