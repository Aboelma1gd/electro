import 'package:flutter/material.dart';
import 'package:electro/features/home/presentation/widgets/category_item.dart';
import 'package:electro/features/home/domain/entities/category_entity.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryEntity> categories;
  final double screenWidth;
  final double screenHeight;

  const CategoryList({super.key, required this.categories, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryItem(
          category: categories[index],
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        );
      },
    );
  }
}
