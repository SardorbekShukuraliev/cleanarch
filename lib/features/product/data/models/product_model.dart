import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,
    required super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.reviews,
    required super.returnPolicy,
    required super.meta,
    required super.images,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      category: json['category'] ?? "",
      price: json['price']?.toDouble() ?? 0,
      discountPercentage: json['discountPercentage']?.toDouble() ?? 0,
      rating: json['rating'] ?? 0,
      stock: json['stock'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'] ?? "",
      sku: json['sku'] ?? "",
      weight: json['weight'],
      dimensions: DimensionsModel.fromJson(json['dimensions'] ?? {}),
      warrantyInformation: json['warrantyInformation'] ?? "",
      shippingInformation: json['shippingInformation'] ?? "",
      availabilityStatus: json['availabilityStatus'] ?? "",
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((review) =>
                  ReviewModel.fromJson(review as Map<String, dynamic>))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy'] ?? "",
      meta: MetaModel.fromJson(json['meta'] ?? {}),
      images: List<String>.from(json['images'] ?? {}),
      thumbnail: json['thumbnail'] ?? "",
    );
  }
}

class DimensionsModel extends Dimensions {
  DimensionsModel({
    //required super.width,
    //required super.height,
    required super.depth,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
      // width: json['width'] ?? 0,
      // height: json['height'],
      depth: json['depth'] ?? 0,
    );
  }
}

class ReviewModel extends Review {
  ReviewModel({
    required int rating,
    required String comment,
    required DateTime date,
    required String reviewerName,
    required String reviewerEmail,
  }) : super(
          rating: rating,
          comment: comment,
          date: date,
          reviewerName: reviewerName,
          reviewerEmail: reviewerEmail,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

class MetaModel extends Meta {
  MetaModel({
    required String createdAt,
    required String updatedAt,
    required String barcode,
    required String qrCode,
  }) : super(
          createdAt: createdAt,
          updatedAt: updatedAt,
          barcode: barcode,
          qrCode: qrCode,
        );

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      barcode: json['barcode'] ?? "",
      qrCode: json['qrCode'] ?? "",
    );
  }
}
