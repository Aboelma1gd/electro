import 'package:flutter/material.dart';
import 'package:electro/features/cart/presentation/widgets/cart_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    // Force rebuild and refresh cart data when the view is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().getcarts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CartViewBody();
  }
}
