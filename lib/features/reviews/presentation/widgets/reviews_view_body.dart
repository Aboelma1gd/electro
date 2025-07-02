import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:electro/features/reviews/presentation/cubit/reviews_state.dart';
import 'package:electro/features/reviews/presentation/screens/add_review_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsView extends StatelessWidget {
  final ProductEntity product;
  const ReviewsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReviewsCubit>(param1: product.productId.toString()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reviews", style: TextStyles.textinhome),
          backgroundColor: AppColors.background,
        ),
        body: ReviewsBody(product: product), // ضع محتوى الصفحة في Widget منفصلة
      ),
    );
  }
}

class ReviewsBody extends StatelessWidget {
  final ProductEntity product;
  const ReviewsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      children: [
        BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            if (state is ReviewsLoaded) {
              return state.reviews.isEmpty
                  ? const Center(child: Text("No Reviews", style: TextStyles.textinhome))
                  : ListView.builder(
                      itemCount: state.reviews.length,
                      itemBuilder: (context, index) {
                        final review = state.reviews[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.secondBackground,
                            ),
                            child: ListTile(
                              title: Text(review.name, style: TextStyles.textinhome),
                              subtitle: Text(
                                review.review,
                                style: TextStyles.textinhome.copyWith(color: Colors.grey, fontSize: screenWidth * 0.04),
                              ),
                              trailing: Text("⭐ ${review.rating}", style: TextStyles.textinhome.copyWith(color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    );
            } else if (state is ReviewsError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        Positioned(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          bottom: screenHeight * 0.03,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final newReview = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReviewView(productId: product.productId.toString()),
                  ),
                );

                if (newReview != null) {
                  context.read<ReviewsCubit>().addReview(newReview);
                }
              },
              child: const Text('Add Review', style: TextStyles.textinhome),
            ),
          ),
        ),
      ],
    );
  }
}
