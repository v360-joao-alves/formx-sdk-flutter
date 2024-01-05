import 'package:formx_sdk_flutter/src/models/bbox.dart';

/// Recognized Document by FormX
class Document {
  Document(this.type, this.bbox);
  final String type;
  final Bbox bbox;
}
