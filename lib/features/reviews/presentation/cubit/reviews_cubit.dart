import 'package:electro/features/reviews/domain/entities/review_entity.dart';
import 'package:electro/features/reviews/domain/usecases/reviews_usecase.dart';
import 'package:electro/features/reviews/presentation/cubit/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsUsecase reviewsUsecase;
  final TextEditingController reviewController;
  final TextEditingController nameController;
  final String productId;
  double selectedRating = 0;
  final formkey = GlobalKey<FormState>();

  ReviewsCubit({
    required this.reviewsUsecase,
    required this.reviewController,
    required this.nameController,
    required this.productId,
  }) : super(ReviewsInitial()) {
    getReviews();
  }

  Future<void> getReviews() async {
    if (productId.isEmpty) {
      emit(const ReviewsError(message: 'Product ID is missing'));
      return;
    }

    emit(ReviewsLoading());
    final result = await reviewsUsecase.getReviews(productId);

    result.fold(
      (failure) => emit(ReviewsError(message: failure.message)),
      (reviews) => emit(ReviewsLoaded(reviews: reviews)),
    );
  }

  Future<ReviewEntity?> addReview(ReviewEntity review) async {
    if (productId.isEmpty) {
      emit(const ReviewsError(message: 'Product ID is missing'));
      return null;
    }

    // Update UI initially
    List<ReviewEntity> currentReviews = [];
    if (state is ReviewsLoaded) {
      currentReviews = List.from((state as ReviewsLoaded).reviews);
    }
    currentReviews.insert(0, review);
    emit(ReviewsLoaded(reviews: currentReviews));

    // Send data to API
    final result = await reviewsUsecase.addReview(review, productId);

    return result.fold(
      (failure) {
        currentReviews.removeWhere((r) => r.id == review.id);
        emit(ReviewsLoaded(reviews: currentReviews));
        emit(ReviewsError(message: failure.message));
        return null;
      },
      (_) {
        reviewController.clear();
        nameController.clear();
        selectedRating = 0;
        return review;
      },
    );
  }
}
