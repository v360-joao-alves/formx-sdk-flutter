sealed class FormXAutoExtractionItem {}

/// The value of extraction structure of a single purchase info item
class FormXAutoExtractionPurchaseInfoItemValue {
  final String name;
  final double amount;
  final String discount;
  final String sku;
  final int quantity;
  final double unitPrice;
  FormXAutoExtractionPurchaseInfoItemValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        amount = json["amount"] as double,
        discount = json["discount"] as String,
        sku = json["sku"] as String,
        quantity = json["quantity"] as int,
        unitPrice = json["unitPrice"] as double;
}

/// Extraction structure of a set of purchase info item
class FormXAutoExtractionPurchaseInfoItem extends FormXAutoExtractionItem {
  final String name;
  final List<FormXAutoExtractionPurchaseInfoItemValue> value;

  FormXAutoExtractionPurchaseInfoItem(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = (json["value"] as List<Object?>)
            .map((v) => FormXAutoExtractionPurchaseInfoItemValue(
                v as Map<Object?, Object?>))
            .toList();
}

/// Extraction structure of a single integer value
class FormXAutoExtractionIntValue extends FormXAutoExtractionItem {
  final String name;
  final int value;
  FormXAutoExtractionIntValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as int;
}

/// Extraction structure of a single string value
class FormXAutoExtractionStringValue extends FormXAutoExtractionItem {
  final String name;
  final String value;
  FormXAutoExtractionStringValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as String;
}

/// Extraction structure of unknown value
class FormXAutoExtractionUnsupportedValue extends FormXAutoExtractionItem {
  final String name;
  final String value;
  FormXAutoExtractionUnsupportedValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as String;
}
