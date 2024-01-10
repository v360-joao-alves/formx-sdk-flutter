sealed class FormXAutoExtractionItem {}

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

/// The purchase inforamtion of a receipt
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

/// An auto extracted string value
class FormXAutoExtractionStringValue extends FormXAutoExtractionItem {
  final String name;
  final String value;
  FormXAutoExtractionStringValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as String;
}

/// An unknown extracted value
class FormXAutoExtractionUnsupportedValue extends FormXAutoExtractionItem {
  final String name;
  final String value;
  FormXAutoExtractionUnsupportedValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as String;
}
