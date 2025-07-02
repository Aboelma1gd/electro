import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/features/home/presentation/widgets/details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class ReviewsInDetails extends StatelessWidget {
  const ReviewsInDetails({
    super.key,
    required this.widget,
    required this.screenHeight,
    required this.averageRating,
  });

  final DetailsViewBody widget;
  final double screenHeight;
  final double averageRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Reviews', style: TextStyles.textinhome),
            const Spacer(),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
      '/reviews',
      extra: widget.product, // تمرير المنتج عبر extra
    );
              },
              child: Text(
                'See All',
                style: TextStyles.textinhome.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        Row(
          children: [
            widget.product.reviews.isNotEmpty
                ? RatingBarIndicator(
                  rating: averageRating,
                  itemBuilder:
                      (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 24.0,
                )
                : RatingBarIndicator(
                  rating: averageRating,
                  itemBuilder:
                      (context, index) =>
                          const Icon(Icons.star, color: Colors.grey),
                  itemCount: 5,
                  itemSize: 24.0,
                ),
          ],
        ),
      ],
    );
  }
}