import 'package:formx_sdk_flutter/models/bbox.dart';

/// Recognized object by FormX
class Document {
  Document(this.type, this.bbox);
  final String type;
  final Bbox bbox;
}
