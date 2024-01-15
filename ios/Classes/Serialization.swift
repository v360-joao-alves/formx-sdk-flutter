//
//  Serialization.swift
//  formx_sdk_flutter
//
//  Created by wu mark on 2023/12/19.
//

import Foundation
import FormX

extension FormXDataValue {
    func toMap() -> [String: Any?] {
        switch self {
        case .intValue(let value):
            return [
                "type": "FormXDataNumValue",
                "value": Double(value),
            ]
        case .doubleValue(let value):
            return [
                "type": "FormXDataNumValue",
                "value": value,
            ]
        case .listProduct(let productItems):
            return [
                "type": "FormXDataProductListValue",
                "value": productItems.map({ productItem in
                    [
                            "name": productItem.name ?? "",
                            "sku": productItem.sku ?? "",
                            "quantity": productItem.quantity ?? 0,
                            "amount": productItem.amount ?? 0.0,
                            "unitPrice": productItem.unitPrice ?? 0.0,
                            "discount": productItem.discount ?? "0",
                            ]
                })
            ]
        case .stringValue(let value):
            return [
                "type": "FormXDataStringValue",
                "value": value,
            ]
        case .intList(let list):
            return [
                "type": "FormXDataNumListValue",
                "value": list.map { Double($0) }
            ]
        case .doubleList(let list):
            return [
                "type": "FormXDataNumListValue",
                "value": list
            ]
        case .unsupported:
            return [
                "type": "FormXDataUnknownValue",
                "value": nil,
            ]
        case .boolValue(let value):
            return [
                "type": "FormXDataBoolValue",
                "value": value,
            ]
        case .boolList(let list):
            return [
                "type": "FormXDataBoolListValue",
                "value": list,
            ]
        case .stringList(let list):
            return [
                "type": "FormXDataStringListValue",
                "value": list,
            ]
        case .map(let map):
            return [
                "type": "FormXDataMapValue",
                "value": map,
            ]
        case .mapList(let list):
            return [
                "type": "FormXDataMapListValue",
                "value": list,
            ]
        }
    }
}

extension ExtractMetaData {
    func toMap() -> [String: Any?] {
        return [
            "extractorId": extractorId,
            "jobId": jobId,
            "usage": usage,
            "requestId": requestId,
        ]
    }
}

extension FormXData {
    func toMap() -> [String: Any?] {
      return [
        "value": value.toMap(),
        "valueType": valueType,
        "confidence": confidence,
        "extractedBy": extractedBy
      ]
    }
}

extension ExtractDocumentMetaData {
    
    func toMap() -> [String: Any?] {
        return [
            "extractorType": extractorType,
            "pageNo": pageNo,
            "sliceNo": sliceNo,
            "orientation": orientation
        ]
    }
}

extension ExtractDocument {
    func toMap() -> [String: Any?] {
      return [
        "type": "ExtractDocument",
        "extractorId": extractorId,
        "documentType": type,
        "typeConfidence": typeConfidence,
        "metaData": metadata.toMap(),
        "data": data.toMap(),
        "detailedData": detailedData.mapValues({ d in
            d.map { $0.toMap() }
        }),
        "boundingBox": boundingBox
      ]
    }
}

extension ExtractDocumentError.Error {
    func toMap() -> [String: Any?] {
        return [
            "code": code,
            "message": message,
            "info": info,
        ]
    }
}

extension ExtractDocumentError {
    func toMap() -> [String: Any?] {
        return [
            "type": "ExtractDocumentError",
            "extractorId": extractorId,
            "metaData": metaData.toMap(),
            "error": error.toMap()
        ]
    }
}

extension FormXAPIExtractResult {
    func toMap() -> [String: Any] {
        return [
            "status": self.response.status,
            "metaData": self.response.metadata.toMap(),
            "documents": self.response.documents.map({ result in
                switch result {
                case .failed(let error):
                    error.toMap()
                case .success(let doc):
                    doc.toMap()
                }
            })
        ]
    }
}

extension FormXAPIDetectDocumentsResult {
    func toMap() -> [String: Any] {
        return [
            "status": response.status,
            "documents": response.documents.map({ region in
                return [
                    "bbox": [
                        "left": region.bbox[0],
                        "top": region.bbox[1],
                        "right": region.bbox[2],
                        "bottom": region.bbox[3],
                    ],
                    "type": region.type,
                ]
            }),
        ]
    }
}

extension FormXError {
    
    func toMap() -> [String: Any] {
      return [
        "code": self.code,
        "message": self.message,
      ]
    }
}

extension [String:FormXData?] {
    func toMap() -> [String: Any?] {
        return self.mapValues { v in
            if let v = v {
                return [
                    "confidence": v.confidence,
                    "value": v.value.toMap(),
                    "valueType": v.valueType,
                    "extractedBy": v.extractedBy
                ]
            }
            return nil
        }
    }
}

