import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter/models/formx_detect_documents_result.dart';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formxSdkFlutterPlugin = FormxSdkFlutter();
  final _picker = ImagePicker();
  FormXDetectDocumentsResult? _detectResult;

  @override
  void initState() {
    super.initState();
    setupFormXSDK();
  }

  Future<void> setupFormXSDK() async {
    try {
      await _formxSdkFlutterPlugin.init(
          formId: dotenv.env["FORMX_FORM_ID"]!,
          accessToken: dotenv.env["FORMX_ACCESS_TOKEN"]!,
          endpoint: dotenv.env["FORMX_API_HOST"]);
    } on PlatformException catch (error) {
      debugPrint(error.message);
    }
    if (!mounted) return;
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
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
                    child: const Text('Detect image'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
