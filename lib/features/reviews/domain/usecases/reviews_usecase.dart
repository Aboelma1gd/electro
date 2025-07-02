import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/reviews/domain/repositories/reviews_repositry.dart';
import 'package:dartz/dartz.dart';
import '../entities/review_entity.dart';

class ReviewsUsecase {
  final ReviewsRepository repository;

  ReviewsUsecase(this.repository);

  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId) {
    return repository.getProductReviews(productId);
  }

  Future<Either<Failure, Unit>> addReview(ReviewEntity review, String productId) {
    return repository.addReview(review,productId);
  }
}