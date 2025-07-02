import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:electro/features/home/presentation/widgets/category_item_shape.dart';

class CategoryLoadingShimmer extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const CategoryLoadingShimmer({super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.white,
      period: const Duration(seconds: 2),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => CategoryShapeItem(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
      ),
    );
  }
}
