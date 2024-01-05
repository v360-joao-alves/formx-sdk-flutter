import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter_example/components/extraction_result_view.dart';

class ExtractionScreen extends StatefulWidget {
  final Uri imagePath;
  const ExtractionScreen(this.imagePath, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExtractionScreenState();
  }
}

class _ExtractionScreenState extends State<ExtractionScreen> {
  bool _isExtracting = false;

  FormXExtractionResult? _result;

  _startExtraction() async {
    setState(() {
      _isExtracting = true;
    });

    try {
      _result = await FormXSDK.extract(widget.imagePath.toFilePath());
      setState(() {
        _isExtracting = false;
      });
    } on PlatformException catch (error) {
      _showMessage(error.message ?? "Error occurs");
      setState(() {
        _isExtracting = false;
      });
    }
  }

  _showMessage(String message) {
    if (mounted) {
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(title: const Text("Error"), content: Text(message)));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _startExtraction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipt"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child:
                  Image.file(key: UniqueKey(), File.fromUri(widget.imagePath)),
            ),
            if (_result != null)
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey,
                  child: ExtractionResultView(_result!),
                ),
              ),
            if (_isExtracting)
              const Flexible(
                flex: 1,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
