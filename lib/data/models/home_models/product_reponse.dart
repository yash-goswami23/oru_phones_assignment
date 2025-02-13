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
  final String deviceCondition;
  final String listedBy;
  final String deviceStorage;
  final List<pic> images;
  final DefaultImage defaultImage;
  final String listingState;
  final String listingLocation;
  final String listingLocality;
  final String listingPrice;
  final String make;
  final String marketingName;
  final bool openForNegotiation;
  final double? discountPercentage;
  final bool verified;
  final String listingId;
  final String status;
  final String verifiedDate;
  final String listingDate;
  final String deviceRam;
  final String warranty;
  final String imagePath;
  final String createdAt;
  final String updatedAt;
  final Location location;
  final int? originalPrice;
  final int? discountedPrice;

  Product({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.images,
    required this.defaultImage,
    required this.listingState,
    required this.listingLocation,
    required this.listingLocality,
    required this.listingPrice,
    required this.make,
    required this.marketingName,
    required this.openForNegotiation,
    this.discountPercentage,
    required this.verified,
    required this.listingId,
    required this.status,
    required this.verifiedDate,
    required this.listingDate,
    required this.deviceRam,
    required this.warranty,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    this.originalPrice,
    this.discountedPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      deviceCondition: json['deviceCondition'],
      listedBy: json['listedBy'],
      deviceStorage: json['deviceStorage'],
      images:
          (json['images'] as List).map((image) => pic.fromJson(image)).toList(),
      defaultImage: DefaultImage.fromJson(json['defaultImage']),
      listingState: json['listingState'],
      listingLocation: json['listingLocation'],
      listingLocality: json['listingLocality'],
      listingPrice: json['listingPrice'],
      make: json['make'],
      marketingName: json['marketingName'],
      openForNegotiation: json['openForNegotiation'],
      discountPercentage: json['discountPercentage']?.toDouble(),
      verified: json['verified'],
      listingId: json['listingId'],
      status: json['status'],
      verifiedDate: json['verifiedDate'],
      listingDate: json['listingDate'],
      deviceRam: json['deviceRam'],
      warranty: json['warranty'],
      imagePath: json['imagePath'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      location: Location.fromJson(json['location']),
      originalPrice: json['originalPrice'],
      discountedPrice: json['discountedPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'deviceCondition': deviceCondition,
      'listedBy': listedBy,
      'deviceStorage': deviceStorage,
      'images': images.map((image) => image.toJson()).toList(),
      'defaultImage': defaultImage.toJson(),
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
      'location': location.toJson(),
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
