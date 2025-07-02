// ignore_for_file: file_names
import 'package:electro/features/reviews/domain/repositories/reviews_repositry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failure.dart';
import '../../domain/entities/review_entity.dart';
import '../models/review_model.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final FirebaseFirestore firestore;

  ReviewsRepositoryImpl(this.firestore);

  @override
Future<Either<Failure, List<ReviewEntity>>> getProductReviews(String productId) async {
  try {
    final docSnapshot = await firestore.collection('Allproducts').doc(productId).get();

    if (!docSnapshot.exists) {
      return const Left(ServerFailure('Product not found'));
    }

    final data = docSnapshot.data();
    if (data == null || !data.containsKey('reviews')) {
      return const Right([]); // Return empty list if no reviews exist
    }

    // Safely cast and convert the reviews data
    final reviewsList = (data['reviews'] as List<dynamic>).map((reviewData) {
      if (reviewData is Map<String, dynamic>) {
        return ReviewModel.fromJson(reviewData);
      }
      throw const FormatException('Invalid review data format');
    }).toList();

    return Right(reviewsList);
  } catch (e) {
    return Left(ServerFailure('Failed to fetch reviews: $e'));
  }
}

  @override
  Future<Either<Failure, Unit>> addReview(ReviewEntity review, String productId) async {
  try {
    final productRef = firestore.collection('Allproducts').doc(productId);

    // تحقق مما إذا كان المنتج موجودًا
    final docSnapshot = await productRef.get();
    if (!docSnapshot.exists) {
      return const Left(ServerFailure('Product not found'));
    }

    // تحويل ReviewEntity إلى Map
    final reviewMap = {
      'id': review.id,
      'name': review.name,
      'review': review.review,
      'rating': review.rating,
      'productId': productId,
      'timestamp': Timestamp.fromDate(review.timestamp),
    };

    // تحديث المستند وإضافة المراجعة
    await productRef.update({
      'reviews': FieldValue.arrayUnion([reviewMap])
    });

    return const Right(unit);
  } catch (e) {
    return Left(ServerFailure('Failed to add review: $e'));
  }
}

}