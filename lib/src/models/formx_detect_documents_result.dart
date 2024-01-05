import 'package:formx_sdk_flutter/src/models/bbox.dart';
import 'package:formx_sdk_flutter/src/models/document.dart';

/// FormX Document Detector Result
class FormXDetectDocumentsResult {
  final String status;
  final List<Document> documents;

  FormXDetectDocumentsResult(Map<Object?, Object?> json)
      : status = json["status"] as String,
        documents = (json["documents"] as List<Object?>).map((document) {
          final doc = document as Map<Object?, Object?>;
          final b = doc["bbox"] as Map<Object?, Object?>;
          return Document(
              doc["type"] as String,
              Bbox(b["left"] as int, b["top"] as int, b["right"] as int,
                  b["bottom"] as int));
        }).toList();
}
