-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}-keep,allowobfuscation @interface com.google.gson.annotations.SerializedName

-keep public class * extends ai.formx.mobile.sdk.FormXDataValue