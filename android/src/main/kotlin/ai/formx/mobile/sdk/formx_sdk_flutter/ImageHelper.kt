package ai.formx.mobile.sdk.formx_sdk_flutter

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.ByteArrayOutputStream
import java.io.File

object ImageHelper {
    fun readBytes(imagePath: String): ByteArray {
        val bitmap = BitmapFactory.decodeFile(File(imagePath.removePrefix("file://")).absolutePath)
        val byteStream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, byteStream)
        bitmap.recycle()
        return byteStream.toByteArray()
    }
}