class BrandResponse {
  final String reason;
  final int statusCode;
  final String status;
  final List<Brand> dataObject;

  BrandResponse({
    required this.reason,
    required this.statusCode,
    required this.status,
    required this.dataObject,
  });

  factory BrandResponse.fromJson(Map<String, dynamic> json) {
    return BrandResponse(
      reason: json['reason'],
      statusCode: json['statusCode'],
      status: json['status'],
      dataObject: (json['dataObject'] as List)
          .map((brand) => Brand.fromJson(brand))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'statusCode': statusCode,
      'status': status,
      'dataObject': dataObject.map((brand) => brand.toJson()).toList(),
    };
  }
}

class Brand {
  final String make;
  final String imagePath;

  Brand({
    required this.make,
    required this.imagePath,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      make: json['make'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'imagePath': imagePath,
    };
  }
}
