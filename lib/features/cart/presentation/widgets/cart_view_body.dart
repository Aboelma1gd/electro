import 'package:electro/core/widgets/details_shopping_prices.dart';
// import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
// import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:electro/features/cart/presentation/widgets/container_in_cart.dart';
// import 'package:go_router/go_router.dart';
// import 'package:electro/config/extentions/extension.dart';
import 'package:electro/injection.dart' as di;
import 'package:electro/config/routing/routes.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/config/routing/routing_app.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: di.sl<CartCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name == 'home') {
                AppRouter.router.go(Routes.home);
              } else {
                AppRouter.router.go(Routes.home);
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            'Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is CartError) {
                    return Expanded(
                      child: Center(child: Text(state.message)),
                    );
                  }
                  if (state is CartLoaded) {
                    return Expanded(
                      child: Column(
                        children: [
                          _buildCartCount(state.cartItems.length),
                          Expanded(
                            child: state.cartItems.isEmpty
                                ? const Center(
                                    child: Text('Your cart is empty'))
                                : ListView.builder(
                                    itemCount: state.cartItems.length,
                                    itemBuilder: (context, index) {
                                      final item = state.cartItems[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.02,
                                        ),
                                        child: ContainerIncart(
                                          index: index,
                                          onRemove: () {
                                            context
                                                .read<CartCubit>()
                                                .deletecart(item.id.toString());
                                          },
                                          cartItemEntity: item,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          DetailsAboutShoppingPrices(
                            text1: 'Checkout',
                            cartItems: state.cartItems,
                            cartCubit: context.read<CartCubit>(),
                            onCheckoutPressed: () {
                              if (state.cartItems.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Your cart is empty. Please add items before checkout'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                return;
                              }
                              AppRouter.router.push(Routes.checkout);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCartCount(int itemCount) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text('You have $itemCount items in your cart'),
  );
}
