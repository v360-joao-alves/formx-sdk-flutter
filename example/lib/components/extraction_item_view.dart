import 'package:flutter/material.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter_example/components/extraction_key_value_view.dart';
import 'package:go_router/go_router.dart';

class ExtractionItemView extends StatelessWidget {
  final FormXAutoExtractionItem item;

  const ExtractionItemView(this.item, {super.key});

  String _titleOf(FormXAutoExtractionItem item) {
    switch (item) {
      case FormXAutoExtractionIntValue():
        return item.name;
      case FormXAutoExtractionStringValue():
        return item.name;
      case FormXAutoExtractionPurchaseInfoItem():
        return item.name;
      case FormXAutoExtractionUnsupportedValue():
        return item.name;
    }
  }

  _showDetail(BuildContext context, FormXAutoExtractionPurchaseInfoItem item) {
    context.push("/nest_value_info", extra: item);
  }

  Widget _buildValueWidget(BuildContext context, FormXAutoExtractionItem item) {
    switch (item) {
      case FormXAutoExtractionIntValue():
        return Text(item.value.toString());
      case FormXAutoExtractionStringValue():
        return Text(item.value);
      case FormXAutoExtractionUnsupportedValue():
        return Text(item.value);
      case FormXAutoExtractionPurchaseInfoItem():
        return ElevatedButton(
          onPressed:
              item.value.isNotEmpty ? () => {_showDetail(context, item)} : null,
          child: const Text("DETAIL"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExtractionKeyValueView(
      title: _titleOf(item),
      child: _buildValueWidget(context, item),
    );
  }
}
