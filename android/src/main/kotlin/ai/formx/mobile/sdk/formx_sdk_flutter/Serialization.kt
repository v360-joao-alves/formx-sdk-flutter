package ai.formx.mobile.sdk.formx_sdk_flutter

import ai.formx.mobile.sdk.FormXAPIDetectDocumentsResponse

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