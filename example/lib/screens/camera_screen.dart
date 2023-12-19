import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detectOnServer = GoRouterState.of(context).extra as bool;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
      ),
      body: Text("detect on server: $detectOnServer"),
    );
  }
}
