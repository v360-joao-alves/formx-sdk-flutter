# formx_sdk_flutter

Using FormX SDK within Flutter application


## Platform Support

|  Android   |      iOS      | MacOS |  Web  | Linux | Windows |
| :--------: | :-----------: | :---: | :---: | :---: | :-----: |
| ✅(SDK 26+) | ✅ (iOS 11.0+) |   ❌   |   ❌   |   ❌   |    ❌    |

## Usage

### FormXCameraView

#### Setup

<details>
<summary>Android</summary>

Please changed your activity with `FlutterFragmentActivity`

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


#### Camera permission

To use `FormXCameraView`, `Camera` permission must be granted. Recommend to use flutter plugin like [permission_handler](https://pub.dev/packages/permission_handler) to handle it.



#### Eembed `FormXCameraView` in flutter app

_Please refer to example app for details_

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

