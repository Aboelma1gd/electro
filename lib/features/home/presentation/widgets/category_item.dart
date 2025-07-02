import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:electro/features/home/domain/entities/category_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/config/routing/routes.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  final double screenWidth;
  final double screenHeight;

  const CategoryItem({
    super.key,
    required this.category,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('${Routes.products}/${category.id}');
      
        print(category.id);
      },
      
      child: Padding(
        padding: EdgeInsets.only(right: screenWidth * 0.05),
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.13,
              height: screenWidth * 0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: category.image.toString(),
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              category.title.toString(),
              style: TextStyle(fontSize: screenWidth * 0.035),
            ),
          ],
        ),
      ),
    );
  }
}