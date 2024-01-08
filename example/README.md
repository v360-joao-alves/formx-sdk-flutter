# formx_sdk_flutter_example

Demonstrates how to use the formx_sdk_flutter plugin to capture & extract documents.

## Getting Started

First, you will need an Access Token and the Form ID of a Pre-Built Receipt Extractor from the FormX portal.

1. Access Tokens:
  - Open 'Access Token' tab of 'Manage Team' page on FormX Portal.
  - Click 'Create Token' button
  - Enter a name for the token and create it.
  - Copy the `Access Token` and proceed with SDK configuration
2. Form ID:
   - Click 'Create new extractor' button of 'Extractors' page on FormX Portal.
   - Select 'Receipts' in the list of built-in extractors.
   - Enter a name for the extractor and create it.
   - Open 'Extract' tab in your extractor detail page to obtain the `Form ID`.

Created `.env` in example project then configure the FormX SDK using the `form id` and `access token`:

```bash
# example/.env

FORMX_FORM_ID=<FORM ID>
FORMX_ACCESS_TOKEN=<ACCESS TOKEN>
```

## Capture Documents

By default, the camera view detect object using offline ML models.  To detect documents using FormX API, pass `DetectMode.online` as detectMode argument and make sure network is up.

```dart
import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';

FormXCameraView(
  detectMode: DetectMode.online,
  controller: _controller,
  onClose: _onCloseCamera,
  onCaptured: _onCaptured,
  onCaptureError: _onCaptureError,
)
```


## Extract Documents

Once the image is ready, we can utilize FormX SDK to further extract document structures.

```
  _onCaptured(Uri imagePath) async {
    try {
      final extractionResult = await FormXSDK.extract(widget.imagePath.toFilePath());
      // TODO: write your custom logic here
    } on PlatformException catch (error) {
      // TODO: handle error
    }
  }
```






