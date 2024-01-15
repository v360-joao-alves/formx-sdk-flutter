package ai.formx.mobile.sdk.formx_sdk_flutter

import ai.formx.mobile.sdk.ExtractDocument
import ai.formx.mobile.sdk.ExtractDocumentError
import ai.formx.mobile.sdk.ExtractDocumentMetaData
import ai.formx.mobile.sdk.ExtractDocumentResult
import ai.formx.mobile.sdk.ExtractMetaData
import ai.formx.mobile.sdk.FormXAPIDetectDocumentsResponse
import ai.formx.mobile.sdk.FormXAPIExtractResponse
import ai.formx.mobile.sdk.FormXDataBoolListValue
import ai.formx.mobile.sdk.FormXDataBoolValue
import ai.formx.mobile.sdk.FormXDataMapListValue
import ai.formx.mobile.sdk.FormXDataMapValue
import ai.formx.mobile.sdk.FormXDataNumListValue
import ai.formx.mobile.sdk.FormXDataNumValue
import ai.formx.mobile.sdk.FormXDataProductListValue
import ai.formx.mobile.sdk.FormXDataStringListValue
import ai.formx.mobile.sdk.FormXDataStringValue
import ai.formx.mobile.sdk.FormXDataUnknownValue
import ai.formx.mobile.sdk.FormXDataValue
import ai.formx.mobile.sdk.FormXProductValue

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
        put("status", status)
        put("metaData", metaData.toMap())
        put("documents", documents.map {
            it.toMap()
        })
    }

fun ExtractMetaData.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("extractorId", extractorId)
        put("requestId", requestId)
        put("usage", usage)
        jobId?.let {
            put("jobId", it)
        }
    }

fun ExtractDocument.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("type", "ExtractDocument")
        put("extractorId", extractorId)
        put("metaData", metaData.toMap())
        type?.let {

            put("documentType", it)
        }
        typeConfidence?.let {
            put("typeConfidence", it)
        }
        put("data", data.mapValues {
            it.value?.toMap()
        })
        put("detailedData", detailedData.mapValues {
            it.value.map { v ->
                v.toMap()
            }
        })
        boundingBox?.let {
            put("boundingBox", it)
        }
    }

fun ExtractDocumentMetaData.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        extractorType?.let {
            put("extractorType", it)
        }
        put("pageNo", pageNo)
        put("sliceNo", sliceNo)
    }

fun FormXProductValue.toMap(): HashMap<String, Any?> =
    HashMap<String, Any?>().apply {
        put("name", name)
        put("amount", amount ?: 0.0)
        put("discount", discount)
        put("sku", sku)
        put("quantity", quantity ?: 0)
        put("unitPrice", unitPrice ?: 0.0)
    }

fun FormXDataValue.toMap(): HashMap<String, Any?> =
    HashMap<String, Any?>().also { it ->
        it["extractedBy"] = extractedBy
        it["confidence"] = confidence
        it["valueType"] = valueType
        it["value"] = HashMap<String, Any?>().also { valueMap ->
            valueMap["type"] = this.javaClass.simpleName
            when (this) {
                is FormXDataBoolListValue -> valueMap["value"] = value
                is FormXDataBoolValue -> valueMap["value"] = value
                is FormXDataMapListValue -> valueMap["value"] = value
                is FormXDataMapValue -> valueMap["value"] = value
                is FormXDataNumListValue -> valueMap["value"] = value.map { it.toDouble() }
                is FormXDataNumValue -> {
                  valueMap["value"] = value.toDouble()
                }
                is FormXDataProductListValue -> valueMap["value"] = value.map { productValue ->
                    productValue.toMap()
                }

                is FormXDataStringListValue -> valueMap["value"] = value
                is FormXDataStringValue -> valueMap["value"] = value
                is FormXDataUnknownValue -> valueMap["value"] = value
            }
        }
    }

fun Error.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("code", code.name)
        put("message", message ?: "")
    }

fun ai.formx.mobile.sdk.Error.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("code", code)
        put("message", message)
        info?.let {
            put("info", it)
        }
    }

fun ExtractDocumentError.toMap(): HashMap<String, Any> =
    HashMap<String, Any>().apply {
        put("type", "ExtractDocumentError")
        put("metaData", metaData.toMap())
        extractorId?.let {
            put("extractorId", it)
        }
        put("error", error.toMap())
    }

fun ExtractDocumentResult.toMap(): HashMap<String, Any> =
    when (this) {
        is ExtractDocument -> this.toMap()
        is ExtractDocumentError -> this.toMap()
    }
