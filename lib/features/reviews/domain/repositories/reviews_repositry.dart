import 'package:electro/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/review_entity.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<ReviewEntity>>> getProductReviews(String productId);
  Future<Either<Failure, Unit>> addReview(ReviewEntity review, String productId);
}