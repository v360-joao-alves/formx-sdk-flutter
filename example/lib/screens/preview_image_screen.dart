import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreviewImageScreen extends StatefulWidget {
  final Uri imagePath;
  const PreviewImageScreen(this.imagePath, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PreviewImageScreenState();
  }
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  _onExtractFormData() {
    context.push("/extraction", extra: widget.imagePath);
  }

  _onRetakePicture() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.file(
                key: UniqueKey(),
                File.fromUri(widget.imagePath),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Please retake if the image is too blurry"),
                  ElevatedButton(
                    onPressed: _onExtractFormData,
                    child: const Text("EXTRACT"),
                  ),
                  ElevatedButton(
                    onPressed: _onRetakePicture,
                    child: const Text("RETAKE PICTURE"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
