import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/reviews/data/models/review_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.productId,
    required super.name,
    required super.price,
    required super.image,
    required super.quantity,
    required super.ratingcount,
    required super.sizes,
    required super.description,
    required super.colors,
    required super.category,
    required super.reviews,
    required super.categoryId,
     required super.salescount, 
    
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
       price: (json['price'] is num) ? json['price'] : double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      ratingcount: json['ratingcount']?.toDouble() ?? 0.0,
      sizes: List<String>.from(json['sizes'] ?? []), 
      description: json['description'] ?? '',
      colors: List<String>.from(json['colors'] ?? []),
      category: json['category'] ?? '',
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((review) => ReviewModel.fromJson(review))
          .toList(),
      categoryId: id,
      salescount: json['salescount'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'productId': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'ratingcount': ratingcount,
      'sizes': sizes,
      'description': description,
      'colors': colors,
      'category': category,
      'reviews': reviews.isNotEmpty
          ? reviews.map((review) => (review as ReviewModel).toJson()).toList()
          : [],
    };
  }

  
}
