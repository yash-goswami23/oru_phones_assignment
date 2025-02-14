class ProductReponse {
  final Data data;

  ProductReponse({
    required this.data,
  });

  factory ProductReponse.fromJson(Map<String, dynamic> json) {
    return ProductReponse(
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class Data {
  final List<Product> data;

  Data({
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: (json['data'] as List)
          .map((listing) => Product.fromJson(listing))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((listing) => listing.toJson()).toList(),
    };
  }
}

class Product {
  final String id;
  final String? deviceCondition;
  final String? listedBy;
  final String? deviceStorage;
  final List<pic> images;
  final DefaultImage? defaultImage;
  final String? listingState;
  final String? listingLocation;
  final String? listingLocality;
  final String? listingPrice;
  final String? make;
  final String? marketingName;
  final bool? openForNegotiation;
  final double? discountPercentage;
  final bool? verified;
  final String? listingId;
  final String? status;
  final String? verifiedDate;
  final String? listingDate;
  final String? deviceRam;
  final String? warranty;
  final String? imagePath;
  final String? createdAt;
  final String? updatedAt;
  final Location? location;
  final int? originalPrice;
  final int? discountedPrice;

  Product({
    required this.id,
    this.deviceCondition,
    this.listedBy,
    this.deviceStorage,
    required this.images,
    this.defaultImage,
    this.listingState,
    this.listingLocation,
    this.listingLocality,
    this.listingPrice,
    this.make,
    this.marketingName,
    this.openForNegotiation,
    this.discountPercentage,
    this.verified,
    this.listingId,
    this.status,
    this.verifiedDate,
    this.listingDate,
    this.deviceRam,
    this.warranty,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.originalPrice,
    this.discountedPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '', // Default to empty string if null
      deviceCondition: json['deviceCondition'] as String?,
      listedBy: json['listedBy'] as String?,
      deviceStorage: json['deviceStorage'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((image) => pic.fromJson(image))
              .toList() ??
          [], // Default to empty list
      defaultImage: json['defaultImage'] != null
          ? DefaultImage.fromJson(json['defaultImage'])
          : null,
      listingState: json['listingState'] as String?,
      listingLocation: json['listingLocation'] as String?,
      listingLocality: json['listingLocality'] as String?,
      listingPrice: json['listingPrice'] as String?,
      make: json['make'] as String?,
      marketingName: json['marketingName'] as String?,
      openForNegotiation: json['openForNegotiation'] as bool?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      verified: json['verified'] as bool?,
      listingId: json['listingId'] as String?,
      status: json['status'] as String?,
      verifiedDate: json['verifiedDate'] as String?,
      listingDate: json['listingDate'] as String?,
      deviceRam: json['deviceRam'] as String?,
      warranty: json['warranty'] as String?,
      imagePath: json['imagePath'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      originalPrice: json['originalPrice'] as int?,
      discountedPrice: json['discountedPrice'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'deviceCondition': deviceCondition,
      'listedBy': listedBy,
      'deviceStorage': deviceStorage,
      'images': images.map((image) => image.toJson()).toList(),
      'defaultImage': defaultImage?.toJson(),
      'listingState': listingState,
      'listingLocation': listingLocation,
      'listingLocality': listingLocality,
      'listingPrice': listingPrice,
      'make': make,
      'marketingName': marketingName,
      'openForNegotiation': openForNegotiation,
      'discountPercentage': discountPercentage,
      'verified': verified,
      'listingId': listingId,
      'status': status,
      'verifiedDate': verifiedDate,
      'listingDate': listingDate,
      'deviceRam': deviceRam,
      'warranty': warranty,
      'imagePath': imagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'location': location?.toJson(),
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
    };
  }
}

class pic {
  final String thumbImage;
  final String fullImage;
  final String isVarified;
  final String option;
  final String id;

  pic({
    required this.thumbImage,
    required this.fullImage,
    required this.isVarified,
    required this.option,
    required this.id,
  });

  factory pic.fromJson(Map<String, dynamic> json) {
    return pic(
      thumbImage: json['thumbImage'],
      fullImage: json['fullImage'],
      isVarified: json['isVarified'],
      option: json['option'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbImage': thumbImage,
      'fullImage': fullImage,
      'isVarified': isVarified,
      'option': option,
      '_id': id,
    };
  }
}

class DefaultImage {
  final String fullImage;
  final String id;

  DefaultImage({
    required this.fullImage,
    required this.id,
  });

  factory DefaultImage.fromJson(Map<String, dynamic> json) {
    return DefaultImage(
      fullImage: json['fullImage'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullImage': fullImage,
      '_id': id,
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;
  final String id;

  Location({
    required this.type,
    required this.coordinates,
    required this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: (json['coordinates'] as List)
          .map((e) => e.toDouble() as double)
          .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
      '_id': id,
    };
  }
}
