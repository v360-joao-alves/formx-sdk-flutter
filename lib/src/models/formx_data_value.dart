sealed class FormXDataValue {
  final String? extractedBy;
  final double? confidence;
  final String? valueType;
  final Object value;

  FormXDataValue(Map<Object?, Object?> json)
      : extractedBy = json["extractedBy"] as String?,
        confidence = json["confidence"] as double?,
        valueType = json["valueType"] as String?,
        value = (json["value"] as Map<Object?, Object?>)["value"] as Object;

  factory FormXDataValue.from(Map<Object?, Object?> json) {
    final valueMap = json["value"] as Map<Object?, Object?>;
    final value = valueMap["value"];

    switch (valueMap["type"]) {
      case "FormXDataNumValue":
        return FormXDataNumValue(json, value as double);
      case "FormXDataBoolValue":
        return FormXDataBoolValue(json, (value as bool));
      case "FormXDataStringValue":
        return FormXDataStringValue(json, (value as String));
      case "FormXDataBoolListValue":
        return FormXDataBoolListValue(
            json, (value as List<Object?>).map((v) => v as bool).toList());
      case "FormXDataStringListValue":
        return FormXDataStringListValue(
            json, (value as List<Object?>).map((v) => v as String).toList());
      case "FormXDataNumListValue":
        return FormXDataNumListValue(
            json, (value as List<Object?>).map((v) => v as double).toList());
      case "FormXDataProductListValue":
        return FormXDataProductListValue(
            json,
            (value as List<Object?>)
                .map((v) => FormXDataProduct(v as Map<Object?, Object?>))
                .toList());
      case "FormXDataMapValue":
        return FormXDataMapValue(
          json,
          (value as Map<Object?, Object?>).map(
            (key, value) => MapEntry(key as String, value),
          ),
        );
      case "FormXDataMapListValue":
        return FormXDataMapListValue(
            json,
            (value as List<Object?>)
                .map(
                  (v) => (v as Map<Object?, Object?>).map(
                    (key, value) => MapEntry(key as String, value),
                  ),
                )
                .toList());
      default:
        return FormXDataUnknownValue(json);
    }
  }
}

class FormXDataNumValue extends FormXDataValue {
  FormXDataNumValue(super.json, this.v);
  final double v;

  @override
  double get value => v;
}

class FormXDataNumListValue extends FormXDataValue {
  FormXDataNumListValue(super.json, this._v);
  final List<double> _v;

  @override
  List<double> get value => _v;
}

class FormXDataBoolValue extends FormXDataValue {
  FormXDataBoolValue(super.json, this.v);
  final bool v;

  @override
  bool get value => v;
}

class FormXDataBoolListValue extends FormXDataValue {
  FormXDataBoolListValue(super.json, this._v);
  final List<bool> _v;

  @override
  List<bool> get value => _v;
}

class FormXDataStringValue extends FormXDataValue {
  FormXDataStringValue(super.json, this.v);
  final String v;

  @override
  String get value => v;
}

class FormXDataStringListValue extends FormXDataValue {
  FormXDataStringListValue(super.json, this._v);
  final List<String> _v;

  @override
  List<String> get value => _v;
}

class FormXDataMapValue extends FormXDataValue {
  FormXDataMapValue(super.json, this.v);
  final Map<String, Object?> v;

  @override
  Map<String, Object?> get value => v;
}

class FormXDataMapListValue extends FormXDataValue {
  FormXDataMapListValue(super.json, this._v);
  final List<Map<String, Object?>> _v;

  @override
  List<Map<String, Object?>> get value => _v;
}

class FormXDataUnknownValue extends FormXDataValue {
  FormXDataUnknownValue(super.json);
}

sealed class FormXAutoExtractionItem {}

class FormXDataProduct {
  final String name;
  final double amount;
  final String discount;
  final String sku;
  final int quantity;
  final double unitPrice;

  FormXDataProduct(
    Map<Object?, Object?> json,
  )   : name = json["name"] as String? ?? "",
        amount = json["amount"] as double? ?? 0.0,
        discount = json["discount"] as String? ?? "",
        sku = json["sku"] as String? ?? "",
        quantity = json["quantity"] as int? ?? 0,
        unitPrice = json["unitPrice"] as double? ?? 0.0;
}

class FormXDataProductListValue extends FormXDataValue {
  FormXDataProductListValue(super.json, this.v);
  final List<FormXDataProduct> v;

  @override
  List<FormXDataProduct> get value => v;
}
