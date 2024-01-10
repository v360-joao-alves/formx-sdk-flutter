import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';

/// The response returned by [FormXSDK.extract]
class FormXExtractionResult {
  String formId;
  String status;
  List<FormXAutoExtractionItem> autoExtractionItems;

  FormXExtractionResult(Map<Object?, Object?> json)
      : formId = json["formId"] as String,
        status = json["status"] as String,
        autoExtractionItems =
            (json["autoExtractionItems"] as List<Object?>).map((it) {
          final item = it as Map<Object?, Object?>;
          final type = item["type"] as String;
          switch (type) {
            case "PurhcaseInfoValueType":
              return FormXAutoExtractionPurchaseInfoItem(item);
            case "IntValueType":
              return FormXAutoExtractionIntValue(item);
            case "StringValueType":
              return FormXAutoExtractionStringValue(item);
          }
          return FormXAutoExtractionUnsupportedValue(item);
        }).toList();
}
