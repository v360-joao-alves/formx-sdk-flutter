package ai.formx.mobile.sdk.formx_sdk_flutter

import ai.formx.mobile.sdk.FormXAPIDetectDocumentsResponse
import ai.formx.mobile.sdk.FormXAPIExtractResponse
import ai.formx.mobile.sdk.FormXAutoExtractionIntItem
import ai.formx.mobile.sdk.FormXAutoExtractionItem
import ai.formx.mobile.sdk.FormXAutoExtractionItemType
import ai.formx.mobile.sdk.FormXAutoExtractionPurchaseInfoItem
import ai.formx.mobile.sdk.FormXAutoExtractionStringItem
import ai.formx.mobile.sdk.FormXDocumentRegion
import ai.formx.mobile.sdk.FormXPointF

fun FormXAPIDetectDocumentsResponse.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("status", status)
        put("documents",
            documents.map {
                HashMap<String, Any>().apply {
                    put("type", it.type)
                    put("bbox", HashMap<String, Int>().apply {
                        put("left", it.bbox[0])
                        put("top", it.bbox[1])
                        put("right", it.bbox[2])
                        put("bottom", it.bbox[3])
                    })
                }
            }
        )
    }

fun FormXAPIExtractResponse.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("formId", formId)
        put("status", status)
        put("autoExtractionItems",
            autoExtractionItems.map { extractionItem ->
                extractionItem.toMap()
            })
    }

fun FormXAutoExtractionItem.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("type", type.name)
        when (type) {
            FormXAutoExtractionItemType.IntValueType -> (value as FormXAutoExtractionIntItem).let {
                put("name", it.name)
                put("value", it.value)
            }

            FormXAutoExtractionItemType.StringValueType -> (value as FormXAutoExtractionStringItem).let {
                put("name", it.name)
                put(
                    "value",
                    it.value
                )
            }

            FormXAutoExtractionItemType.PurhcaseInfoValueType ->
                (value as FormXAutoExtractionPurchaseInfoItem).let { purchaseItem ->
                    put("name", purchaseItem.name)
                    put("value", purchaseItem.value.map { infoItem ->
                        HashMap<String, String>().apply {
                            put("name", infoItem.name ?: "")
                            put("amount", Integer.parseInt(infoItem.amount ?: "0"))
                            put("discount", (infoItem.discount ?: "0").toDouble())
                            put("sku", infoItem.sku ?: "")
                            put("quantity", Integer.parseInt(infoItem.quantity ?: "0"))
                            put("unitPrice", (infoItem.unitPrice ?: "0").toDouble())
                        }
                    })
                }

            FormXAutoExtractionItemType.UnsupportedValueType -> put("value", value.toString())
        }
    }


fun Error.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("code", code.name)
        put("message", message ?: "")
    }