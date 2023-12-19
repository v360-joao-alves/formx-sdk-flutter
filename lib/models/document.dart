import 'package:formx_sdk_flutter/models/bbox.dart';

class Document {
  Document(this.type, this.bbox);
  final String type;
  final Bbox bbox;
}
