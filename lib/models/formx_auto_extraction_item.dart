sealed class FormXAutoExtractionItem {}

class PurchaseInfoItemValue {
  final String name;
  final double amount;
  final String discount;
  final String sku;
  final int quantity;
  final double unitPrice;
  PurchaseInfoItemValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        amount = json["amount"] as double,
        discount = json["discount"] as String,
        sku = json["sku"] as String,
        quantity = json["quantity"] as int,
        unitPrice = json["unitPrice"] as double;
}

class FormXAutoExtractionPurchaseInfoItem extends FormXAutoExtractionItem {
  final String name;
  final List<PurchaseInfoItemValue> value;

  FormXAutoExtractionPurchaseInfoItem(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = (json["value"] as List<Object?>)
            .map((v) => PurchaseInfoItemValue(v as Map<Object?, Object?>))
            .toList();
}

class FormXAutoExtractionIntValue extends FormXAutoExtractionItem {
  final String name;
  final int value;
  FormXAutoExtractionIntValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as int;
}

class FormXAutoExtractionStringValue extends FormXAutoExtractionItem {
  final String name;
  final String value;
  FormXAutoExtractionStringValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as String;
}

class FormXAutoExtractionUnsupportedValue extends FormXAutoExtractionItem {
  final String name;
  final String value;
  FormXAutoExtractionUnsupportedValue(Map<Object?, Object?> json)
      : name = json["name"] as String,
        value = json["value"] as String;
}
