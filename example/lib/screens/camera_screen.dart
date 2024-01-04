import 'package:flutter/material.dart';
import 'package:formx_sdk_flutter/formx_camera_view.dart';
import 'package:formx_sdk_flutter/models/detect_mode.dart';
import 'package:formx_sdk_flutter/models/error.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  late bool detectOnServer;
  PermissionStatus? _cameraPermissionStatus;
  final FormXCameraController _controller = FormXCameraController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => checkCameraPermission());
  }

  void checkCameraPermission() async {
    _cameraPermissionStatus = await Permission.camera.request();

    if (_cameraPermissionStatus != PermissionStatus.granted) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text("Permission request"),
                content: const Text("Please grant camera permission"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                      _onCloseCamera();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ));
    }

    setState(() {});
  }

  _onCloseCamera() {
    _controller.stopCamera();
    context.pop();
  }

  _onCaptured(Uri imagePath) async {
    await context.push("/preview", extra: imagePath);
    _controller.startCamera();
  }

  _onCaptureError(FormXCameraViewError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message),
      ),
    );
  }

  Widget buildEmptyView(PermissionStatus? status) {
    switch (status) {
      case null:
        return const CircularProgressIndicator();
      case PermissionStatus.denied:
        return const Text("Please grant camera permission");
      case PermissionStatus.granted:
        return const SizedBox.shrink();
      default:
        return const Text("Cannot access camera");
    }
  }

  @override
  Widget build(BuildContext context) {
    detectOnServer = GoRouterState.of(context).extra as bool;
    return Scaffold(
      body: _cameraPermissionStatus == PermissionStatus.granted
          ? FormXCameraView(
              controller: _controller,
              detectMode:
                  detectOnServer ? DetectMode.online : DetectMode.offline,
              onClose: _onCloseCamera,
              onCaptured: _onCaptured,
              onCaptureError: _onCaptureError,
            )
          : Center(
              child: buildEmptyView(_cameraPermissionStatus),
            ),
    );
  }
}
