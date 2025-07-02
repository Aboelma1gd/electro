import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/presentation/widgets/details_view_body.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return DetailsViewBody(product: product);
  }
}
