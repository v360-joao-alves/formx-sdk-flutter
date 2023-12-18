package ai.formx.mobile.sdk.formx_sdk_flutter

import ai.formx.mobile.sdk.FormXAPIClient

object FormXSDKInitializer {
    private var accessToken: String? = null
    private var endpoint: String? = null
    var formId: String? = null
    private var currentApiClient: FormXAPIClient? = null

    fun init(formId: String, accessToken: String, endpoint: String? = null) {
        this.formId = formId
        this.accessToken = accessToken
        this.endpoint = endpoint
        this.currentApiClient = FormXAPIClient(accessToken, endpoint)
    }

    val apiClient: FormXAPIClient?
        get() {
            return currentApiClient;
        }

    val isInitialized: Boolean
        get() {
            return accessToken != null && formId != null
        }
}