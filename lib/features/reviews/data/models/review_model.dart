import 'package:electro/features/reviews/domain/entities/review_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.name,
    required super.review,
    required super.rating,
    required super.productId,
    required super.timestamp,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      review: json['review'] ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,  // تحويل إلى int لمنع أخطاء الأنواع
      productId: json['productId'] ?? '',
         timestamp: json['timestamp'] is Timestamp
   ? (json['timestamp'] as Timestamp).toDate()
   : (json['timestamp'] is String
       ? DateTime.tryParse(json['timestamp']) ?? DateTime.now()
       : DateTime.now()),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'review': review,
      'rating': rating,
      'productId': productId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}