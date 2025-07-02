import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/features/cart/data/models/cart_item_model.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:electro/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:electro/features/home/presentation/widgets/details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:electro/config/routing/routes.dart';
import 'package:electro/core/utils/app_colors.dart';

class AddToCartInDetails extends StatelessWidget {
  final DetailsViewBody widget;
  final String? selectedSize;
  final String? selectedColor;
  final int quantity;
  final VoidCallback? onViewCartPressed;

  const AddToCartInDetails({
    super.key,
    required this.widget,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
    this.onViewCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please sign in to add items to cart'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final productscubit = context.read<ProductsCubit>();
        final cartCubit = context.read<CartCubit>();

        final cartItem = CartItemModel(
          selectedColor: selectedColor!,
          selectedSize: selectedSize!,
          quantity: quantity,
          totalPrice: cartCubit.calculateUpdatedTotalPrice(
            widget.product.price.toDouble(),
            quantity,
          ),
          name: widget.product.name,
          image: widget.product.image,
          price: widget.product.price.toDouble(),
          id: widget.product.productId,
        );

        cartCubit.addToCart(cartItem, userId).then((_) {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              cartItem.image,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image,
                                      color: Colors.grey, size: 40),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Added to cart',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cartItem.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              backgroundColor: Colors.black,
                              foregroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'CONTINUE SHOPPING',
                              style: TextStyle(fontSize: 12),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              onViewCartPressed?.call();
                            },
                            child: const Text(
                              'VIEW CART',
                              style: TextStyle(fontSize: 12),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
        productscubit.incrementSalesCount(widget.product.productId);
      },
      child: const Row(
        children: [
          Icon(Icons.add_shopping_cart, color: Colors.white),
          Spacer(),
          Text(
            'Add to Cart',
            style: TextStyles.textinhome,
          ),
        ],
      ),
    );
  }
}
