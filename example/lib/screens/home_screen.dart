import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool _detectOnServer = false;

  _goToCameraScreen() {
    context.push("/camera", extra: _detectOnServer);
  }

  _goToSDKDemoScreen() {
    context.push("/sdk_demo");
  }

  _onToggleDetectOnServer(bool detectOnServer) {
    setState(() {
      _detectOnServer = detectOnServer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FormX Mobile SDK Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Document Extractors"),
            ElevatedButton(
              onPressed: _goToCameraScreen,
              child: const Text("receipts extractor"),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text("Detect on Server"),
                  ),
                  Switch(
                    value: _detectOnServer,
                    onChanged: _onToggleDetectOnServer,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _goToSDKDemoScreen,
              child: const Text("FormX SDK methods"),
            ),
          ],
        ),
      ),
    );
  }
}
