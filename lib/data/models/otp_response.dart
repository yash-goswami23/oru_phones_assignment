class OtpResponse {
  final String? reason;
  final String? status;
  final DataObject? dataObject;
  final List<Error>? errors;

  OtpResponse({
    this.reason,
    this.status,
    this.dataObject,
    this.errors,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      reason: json['reason'],
      status: json['status'],
      dataObject: json['dataObject'] != null
          ? DataObject.fromJson(json['dataObject'])
          : null,
      errors: json['error'] != null
          ? (json['error'] as List)
              .map((error) => Error.fromJson(error))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'status': status,
      'dataObject': dataObject?.toJson(),
      'error': errors?.map((error) => error.toJson()).toList(),
    };
  }
}

class DataObject {
  final String mobileNumber;

  DataObject({
    required this.mobileNumber,
  });

  factory DataObject.fromJson(Map<String, dynamic> json) {
    return DataObject(
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobileNumber,
    };
  }
}

class Error {
  final String code;
  final int minimum;
  final String type;
  final bool inclusive;
  final bool exact;
  final String message;
  final List<String> path;

  Error({
    required this.code,
    required this.minimum,
    required this.type,
    required this.inclusive,
    required this.exact,
    required this.message,
    required this.path,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json['code'],
      minimum: json['minimum'],
      type: json['type'],
      inclusive: json['inclusive'],
      exact: json['exact'],
      message: json['message'],
      path: List<String>.from(json['path']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'minimum': minimum,
      'type': type,
      'inclusive': inclusive,
      'exact': exact,
      'message': message,
      'path': path,
    };
  }
}
