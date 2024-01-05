import 'package:flutter/material.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter_example/components/extraction_item_view.dart';

class ExtractionResultView extends StatelessWidget {
  final FormXExtractionResult result;
  final List<FormXAutoExtractionItem> _extractonItems;

  ExtractionResultView(this.result, {super.key})
      : _extractonItems = result.autoExtractionItems
            .where((item) => item is! FormXAutoExtractionUnsupportedValue)
            .toList();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _extractonItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ExtractionItemView(_extractonItems[index]);
          },
        ),
      ),
    );
  }
}
