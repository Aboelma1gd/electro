import 'package:electro/features/reviews/presentation/widgets/add_review_view_body.dart';
import 'package:flutter/material.dart';

class AddReviewView extends StatelessWidget {
  const AddReviewView({super.key, required this.productId});
   final String productId;
  @override
  Widget build(BuildContext context) {
    return AddReviewViewBody(productId:  productId,);
  }
}