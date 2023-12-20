import 'package:flutter/material.dart';

class ExtractionKeyValueView extends StatelessWidget {
  final String title;
  final Widget child;

  const ExtractionKeyValueView(
      {required this.title, required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey),
      )),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          child,
        ],
      ),
    );
  }
}
