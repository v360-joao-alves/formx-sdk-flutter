//
//  Serialization.swift
//  formx_sdk_flutter
//
//  Created by wu mark on 2023/12/19.
//

import Foundation
import FormX

extension FormXAutoExtractionItem {
    func toMap() -> [String: Any] {
        switch self {
        case .intValue(let intItem):
            return [
                "type": "IntValueType",
                "name": intItem.name,
                "value": intItem.value,
            ]
        case .purchaseInfoValue(let item):
            return [
                "type": "PurhcaseInfoValueType",
                "name": item.name,
                "value": item.value.map({ productItem in
                    return [
                        "name": productItem.name ?? "",
                        "sku": productItem.sku ?? "",
                        "quantity": productItem.quantity ?? 0,
                        "amount": productItem.amount ?? 0.0,
                        "unitPrice": productItem.unitPrice ?? 0.0,
                        "discount": productItem.discount ?? "0",
                    ]
                }),
            ]
        case .stringValue(let strItem):
            return [
                "type": "StringValueType",
                "name": strItem.name,
                "value": strItem.value,
            ]
        case .unsupported:
            return [
                "type": "UnsupportedValueType",
                "name": "",
                "value": "",
            ]
        }
    }
}
extension FormXAPIExtractResult {
    func toMap() -> [String: Any] {
        return [
            "status": self.response.status,
            "formId": self.response.formId,
            "autoExtractionItems": self.response.autoExtractionItems.map({ item in
                return item.toMap()
            }),
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
