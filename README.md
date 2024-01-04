# formx_sdk_flutter

Using FormX SDK within Flutter application


## Platform Support

|  Android   |      iOS      | MacOS |  Web  | Linux | Windows |
| :--------: | :-----------: | :---: | :---: | :---: | :-----: |
| ✅(SDK 26+) | ✅ (iOS 11.0+) |   ❌   |   ❌   |   ❌   |    ❌    |


## Setup

<details>
<summary>Android</summary>

1. Set the `minSdkVersion` in `android/app/build.gradle`:

```
android {
    defaultConfig {
        minSdkVersion 20
    }
}
```

2. Replace base activity with `FlutterFragmentActivity`

```
class MainActivity: FlutterFragmentActivity() {
}
```
</details>

<details>
<summary>iOS</summary>

Update `Podfile` with:
```
target 'Runner' do

  ....skiped...

  pod 'FormX', :git => 'https://github.com/oursky/formx-sdk.git', tag: '0.1.32'

  ....skiped...
```
</details>


## Sample Usage

### FormXCameraView

1. Camera permission

To use `FormXCameraView`, `Camera` permission must be granted. Recommend to use flutter plugin like [permission_handler](https://pub.dev/packages/permission_handler) to handle it.


2. Eembed `FormXCameraView` in flutter app

_Refer to example app for details_

```
Scaffold(
      body: _cameraPermissionStatus == PermissionStatus.granted
          ? FormXCameraView(
              controller: _controller,
              detectMode:
                  detectOnServer ? DetectMode.online : DetectMode.offline,
              onClose: _onCloseCamera,
              onCaptured: _onCaptured,
              onCaptureError: _onCaptureError,
            )
      ...
)
```

