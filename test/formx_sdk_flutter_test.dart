import 'package:flutter_test/flutter_test.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter_platform_interface.dart';
import 'package:formx_sdk_flutter/formx_sdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFormxSdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements FormxSdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FormxSdkFlutterPlatform initialPlatform = FormxSdkFlutterPlatform.instance;

  test('$MethodChannelFormxSdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFormxSdkFlutter>());
  });

  test('getPlatformVersion', () async {
    FormxSdkFlutter formxSdkFlutterPlugin = FormxSdkFlutter();
    MockFormxSdkFlutterPlatform fakePlatform = MockFormxSdkFlutterPlatform();
    FormxSdkFlutterPlatform.instance = fakePlatform;

    expect(await formxSdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
