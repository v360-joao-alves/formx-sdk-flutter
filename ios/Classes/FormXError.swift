//
//  FormXError.swift
//  formx_sdk_flutter
//
//  Created by wu mark on 2023/12/18.
//

import Foundation
import Flutter

enum ErrorCode: String {
    case ValidationError
    case RuntimeError
}

class FormXError {
    
    static func validationError(message: String) -> FormXError {
        return FormXError(code: ErrorCode.ValidationError, message: message)
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
