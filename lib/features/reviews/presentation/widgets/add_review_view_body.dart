import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/features/reviews/domain/entities/review_entity.dart';
import 'package:electro/features/reviews/presentation/cubit/reviews_state.dart';
import 'package:electro/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/features/reviews/presentation/cubit/reviews_cubit.dart';
//import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AddReviewViewBody extends StatelessWidget {
  const AddReviewViewBody({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => sl<ReviewsCubit>(param1: productId),
      child: BlocConsumer<ReviewsCubit, ReviewsState>(
        listener: (context, state) {
          if (state is ReviewsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        
        },
        
        builder: (context, state) {
          var cubit = context.read<ReviewsCubit>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.background,
              title: const Text('Add Review', style: TextStyles.textinhome),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Form(
                  key: cubit.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: cubit.nameController,
                        decoration: const InputDecoration(
                          labelText: "Your Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter Your Name" : null,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        controller: cubit.reviewController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: "Your Review",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter Your Review" : null,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      const Text("Rate:", style: TextStyle(fontSize: 16)),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) => cubit.selectedRating = rating,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Center(
                        child:ElevatedButton(
                               onPressed: () async {
  if (cubit.formkey.currentState!.validate() && cubit.selectedRating > 0) {
    final newReview = ReviewEntity(
      id: const Uuid().v4(),
      name: cubit.nameController.text,
      review: cubit.reviewController.text,
      rating: cubit.selectedRating.toInt(),
      productId: cubit.productId,
      timestamp: DateTime.now(),
    );
    
    final addedReview = await cubit.addReview(newReview);
    if (context.mounted && addedReview != null) {
      Navigator.pop(context, addedReview); // ترجيع الـ review الجديد للصفحة السابقة
    }
  } else if (cubit.selectedRating == 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select a rating")),
    );
  }
},
                                child: const Text("Submit Review",
                                    style: TextStyles.textinhome),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}