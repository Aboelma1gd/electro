import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/widgets/product_item.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class GridViewForProducts extends StatelessWidget {
  const GridViewForProducts({
    super.key, required this.products,
  });
 final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
      itemCount: products.length,
      itemBuilder:
          (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.secondBackground,
            ),
            child: Center(
              child: ProductItem(
                productEntity: products[index],
              ),
            ),
          ),
    );
  }
}