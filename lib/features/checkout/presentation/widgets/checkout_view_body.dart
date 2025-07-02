import 'package:electro/core/widgets/appbartop.dart';
import 'package:electro/core/widgets/details_shopping_prices.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:electro/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:electro/features/checkout/presentation/widgets/address_bottomsheet.dart';
import 'package:electro/features/checkout/presentation/widgets/field_checkout.dart';
import 'package:electro/features/checkout/presentation/widgets/payment_bottomsheet.dart';
import 'package:electro/features/payments/payment_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:electro/config/routing/routes.dart';
// import 'package:go_router/go_router.dart';
import 'package:electro/config/routing/routing_app.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:electro/features/checkout/domain/entities/address_entity.dart';

class CheckoutViewBody extends StatefulWidget {
  final List<CartItemEntity> cartItems;

  const CheckoutViewBody({super.key, required this.cartItems});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  String _selectedPayment = 'Add Payment Method';
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    // Check for existing address when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final checkoutCubit = context.read<CheckoutCubit>();
      String userId = FirebaseAuth.instance.currentUser!.uid;
      checkoutCubit.checkUserAddress(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is AddadressLoaded) {
          // No need to setState _selectedAddress anymore, display uses currentAddress directly
        } else if (state is AddadressError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final checkoutCubit = context.read<CheckoutCubit>();

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.05,
            ),
            child: Column(
              children: [
                const Appbartop(),
                SizedBox(height: screenHeight * 0.05),
                _buildAddressField(checkoutCubit),
                SizedBox(height: screenHeight * 0.03),
                FieldCheckout(
                  text1: 'Payment Method',
                  text2: _selectedPayment,
                  onTap: () => _showPaymentBottomSheet(context),
                ),
                const Spacer(),
                DetailsAboutShoppingPrices(
                  text1: 'Pay Now',
                  onPressed: () async {
                    if (_selectedPayment == 'Add Payment Method') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a payment method'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (!checkoutCubit.hasAddress) {
                      await _showAddressBottomSheet(context);
                      return;
                    }

                    // Process payment based on selected method
                    await _processPayment();
                  },
                  cartItems: widget.cartItems,
                  cartCubit: context.read<CartCubit>(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressField(CheckoutCubit checkoutCubit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipping Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (checkoutCubit.hasAddress)
                TextButton.icon(
                  onPressed: () async {
                    await _showAddressBottomSheet(context,
                        initialAddress: checkoutCubit.currentAddress);
                  },
                  icon: const Icon(Icons.edit, size: 20),
                  label: const Text('Edit'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (checkoutCubit.hasAddress)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${checkoutCubit.currentAddress!.name}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Address: ${checkoutCubit.getFormattedAddress()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mobile Number: ${checkoutCubit.currentAddress!.mobileNumber}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          else
            GestureDetector(
              onTap: () async {
                await _showAddressBottomSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_location_alt, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Add Shipping Address',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _processPayment() async {
    // Calculate total price from cart items
    final totalPrice = widget.cartItems.fold(
      0.0,
      (previousValue, element) => previousValue + element.totalPrice,
    );

    try {
      bool success = false;

      switch (_selectedPaymentMethod) {
        case 'stripe':
          success = await PaymentManager.makePayment(
            totalPrice.toInt(),
            'USD',
            context,
          );
          break;
        case 'COD': // New case for Cash on Delivery
          success =
              true; // COD is always successful from a payment processing standpoint
          break;
      }

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment successful'),
            backgroundColor: Colors.green,
          ),
        );
        // Payment successful - clear cart and navigate to home
        context.read<CartCubit>().clearCart();
        // Pop the current CheckoutView from the root navigator to clean the stack
        Navigator.of(context).popUntil((route) => route.isFirst);
        // Now navigate to home using the global router instance
        AppRouter.router.go(Routes.home);
      }
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment cancelled'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: ${e.error.localizedMessage}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<Map<String, String>?> _showAddressBottomSheet(BuildContext context,
      {AddressEntity? initialAddress}) async {
    final checkoutCubit =
        context.read<CheckoutCubit>(); // Get the existing cubit
    return showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider.value(
        value: checkoutCubit,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(modalContext).viewInsets.bottom,
          ),
          child: AddressBottomSheet(
            initialAddress: initialAddress,
          ),
        ),
      ),
    );
  }

  Future<void> _showPaymentBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PaymentMethodBottomSheet(),
    );

    if (result != null) {
      setState(() {
        _selectedPaymentMethod = result;
        _selectedPayment =
            result == 'stripe' ? 'Pay with Stripe' : 'Cash on Delivery';
      });
    }
  }
}
