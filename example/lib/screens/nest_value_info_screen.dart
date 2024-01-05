import 'package:flutter/material.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter_example/components/extraction_key_value_view.dart';

class NestValueInfoScreen extends StatelessWidget {
  final FormXAutoExtractionPurchaseInfoItem item;
  const NestValueInfoScreen(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Receipt",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
            separatorBuilder: (_, index) => const SizedBox(
                  height: 16,
                ),
            itemCount: item.value.length,
            itemBuilder: (context, index) {
              final value = item.value[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ExtractionKeyValueView(
                          title: "Name", child: Text(value.name)),
                      ExtractionKeyValueView(
                          title: "Sku", child: Text(value.sku)),
                      ExtractionKeyValueView(
                          title: "Amount",
                          child: Text(value.amount.toString())),
                      ExtractionKeyValueView(
                          title: "Discount",
                          child: Text(value.discount.toString())),
                      ExtractionKeyValueView(
                          title: "Quantity",
                          child: Text(value.quantity.toString())),
                      ExtractionKeyValueView(
                          title: "Unit Price",
                          child: Text(value.unitPrice.toString())),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
