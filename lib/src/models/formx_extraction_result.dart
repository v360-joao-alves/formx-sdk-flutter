import 'package:formx_sdk_flutter/formx_sdk_flutter.dart';

class ExtractMetaData {
  final String extractorId;
  final String requestId;
  final int usage;
  final String? jobId;
  ExtractMetaData(Map<Object?, Object?> json)
      : extractorId = json["extractorId"] as String,
        requestId = json["requestId"] as String,
        usage = json["usage"] as int,
        jobId = json["jobId"] as String?;
}

class ExtractDocumentMetaData {
  final List<int> pageNo;
  final int sliceNo;
  final String extractorType;
  final int? orientation;

  ExtractDocumentMetaData(Map<Object?, Object?> json)
      : pageNo =
            (json["pageNo"] as List<Object?>).map((p) => p as int).toList(),
        sliceNo = json["sliceNo"] as int,
        extractorType = json["extractorType"] as String,
        orientation = json["orientation"] as int?;
}

sealed class ExtractDocumentResult {}

class ExtractDocument extends ExtractDocumentResult {
  final String? type;
  final double? typeConfidence;
  final List<double>? boundingBox;
  final String extractorId;
  final ExtractDocumentMetaData metaData;
  final Map<String, FormXDataValue?> data;
  final Map<String, List<FormXDataValue>> detailedData;
  ExtractDocument(Map<Object?, Object?> json)
      : extractorId = json["extractorId"] as String,
        type = json["documentType"] as String?,
        typeConfidence = json["typeConfidence"] as double?,
        boundingBox = (json["boundingBox"] as List<Object?>?)?.cast(),
        metaData = ExtractDocumentMetaData(
          json["metaData"] as Map<Object?, Object?>,
        ),
        data = (json["data"] as Map<Object?, Object?>).map(
          (key, value) {
            final v = value as Map<Object?, Object?>?;
            return MapEntry(
              key as String,
              v == null ? null : FormXDataValue.from(v),
            );
          },
        ),
        detailedData = (json["detailedData"] as Map<Object?, Object?>).map(
          (key, value) => MapEntry(
            key as String,
            (value as List<Object?>)
                .map(
                  (v) => FormXDataValue.from(v as Map<Object?, Object?>),
                )
                .toList(),
          ),
        );
}

class ExtractError {
  ExtractError(Map<Object?, Object?> json)
      : code = json["code"] as int,
        message = json["message"] as String,
        info = (json["info"] as Map<Object?, Object?>?)
            ?.map((key, value) => MapEntry(key as String, value));
  final int code;
  final String message;
  final Map<String, Object?>? info;
}

class ExtractDocumentError extends ExtractDocumentResult {
  ExtractDocumentError(Map<Object?, Object?> json)
      : metaData =
            ExtractDocumentMetaData(json["metaData"] as Map<Object?, Object?>),
        extractorId = json["extractorId"] as String?,
        error = ExtractError(json["error"] as Map<Object?, Object?>);

  final ExtractDocumentMetaData metaData;
  final String? extractorId;
  final ExtractError error;
}

/// The response returned by [FormXSDK.extract]
class FormXExtractionResult {
  final ExtractMetaData extractMetaData;
  final String status;
  final List<ExtractDocumentResult> documents;

  FormXExtractionResult(Map<Object?, Object?> json)
      : extractMetaData =
            ExtractMetaData(json["metaData"] as Map<Object?, Object?>),
        status = json["status"] as String,
        documents = (json["documents"] as List<Object?>).map((it) {
          final v = it as Map<Object?, Object?>;
          final type = v["type"] as String;
          switch (type) {
            case "ExtractDocumentError":
              return ExtractDocumentError(v);
            default:
              return ExtractDocument(v);
          }
        }).toList();
}
