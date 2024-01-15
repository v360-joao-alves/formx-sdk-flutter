import 'package:flutter/material.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter_example/components/extraction_key_value_view.dart';

class ExtractionItemView extends StatelessWidget {
  final FormXDataValue? item;
  const ExtractionItemView({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    switch (item) {
      case FormXDataNumValue(value: final value):
        return Text(value.toString());
      case FormXDataStringValue(value: final value):
        return Text(value);
      case FormXDataBoolValue(value: final value):
        return Text(value.toString());
      case FormXDataMapValue(value: final value):
        return Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: value.entries
                .map(
                  (entry) => ExtractionKeyValueView(
                    title: entry.key,
                    child: Text(
                      entry.value.toString(),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      case FormXDataNumListValue(value: final value):
        return Text(value.join(", "));
      case FormXDataStringListValue(value: final value):
        return Text(value.join(", "));
      case FormXDataBoolListValue(value: final value):
        return Text(value.join(", "));
      case FormXDataMapListValue(value: final value):
        return Column(
          children: value
              .map(
                (v) => Column(
                  children: v.entries
                      .map(
                        (vv) => ExtractionKeyValueView(
                          title: vv.key,
                          child: Text(vv.value.toString()),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        );
      case FormXDataProductListValue(value: var value):
        return Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: value
                .map((v) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExtractionKeyValueView(
                              title: "Name", child: Text(v.name)),
                          ExtractionKeyValueView(
                              title: "Sku", child: Text(v.sku)),
                          ExtractionKeyValueView(
                              title: "Amount",
                              child: Text(v.amount.toString())),
                          ExtractionKeyValueView(
                              title: "Discount",
                              child: Text(v.discount.toString())),
                          ExtractionKeyValueView(
                              title: "Quantity",
                              child: Text(v.quantity.toString())),
                          ExtractionKeyValueView(
                              title: "Unit Price",
                              child: Text(v.unitPrice.toString())),
                        ],
                      ),
                    ))
                .toList(),
          ),
        );
      case null:
      case FormXDataUnknownValue():
        return const SizedBox.shrink();
    }
  }
}
