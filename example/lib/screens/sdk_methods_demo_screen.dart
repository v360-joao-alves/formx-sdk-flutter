import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter/models/formx_detect_documents_result.dart';
import 'package:formx_sdk_flutter/models/formx_extraction_result.dart';
import 'package:image_picker/image_picker.dart';

class SDKMethodsDemoScreen extends StatefulWidget {
  const SDKMethodsDemoScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _SDKMethodsDemoScreenState();
  }
}

class _SDKMethodsDemoScreenState extends State {
  final _picker = ImagePicker();
  FormXDetectDocumentsResult? _detectResult;
  FormXExtractionResult? _extractionResult;
  final _formxSdkFlutterPlugin = FormxSdkFlutter();

  _onDetectImage(BuildContext context) async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _detectResult = null;
      });
      if (image != null) {
        _detectResult = await _formxSdkFlutterPlugin.detect(image.path);
        setState(() {});
      }
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? ""),
      ));
    } on Exception catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  _onExtractFromImage(BuildContext context) async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _detectResult = null;
      });
      if (image != null) {
        _extractionResult = await _formxSdkFlutterPlugin.extract(image.path);
        setState(() {});
      }
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? ""),
      ));
    } on Exception catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SDK Methods Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_detectResult != null)
              Text(
                  "result ${_detectResult!.status}\ndetected document count: ${_detectResult!.documents.length}"),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    _onDetectImage(context);
                  },
                  child: const Text('Detect document'),
                );
              },
            ),
            if (_extractionResult != null)
              Text(
                  "result ${_extractionResult!.status}\nextracted item count: ${_extractionResult!.autoExtractionItems.length}"),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    _onExtractFromImage(context);
                  },
                  child: const Text('Extract from image'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
