import 'package:flutter/material.dart';
import 'package:electro/features/payments/payment_manager.dart';

class PaymentPage extends StatefulWidget {
  final int amount;
  final String currency;

  const PaymentPage({
    Key? key,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  bool isLoading = false;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'id': 'stripe',
      'name': 'Credit Card (Stripe)',
      'icon': Icons.credit_card,
    },
    {
      'id': 'paymob',
      'name': 'Paymob',
      'icon': Icons.payment,
    },
  ];

  Future<void> _handlePayment() async {
    if (selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      bool success = false;

      if (selectedPaymentMethod == 'stripe') {
        success = await PaymentManager.makePayment(
          widget.amount,
          widget.currency,
          context,
        );
      } else if (selectedPaymentMethod == 'paymob') {
        // Implement Paymob payment logic here
        // success = await PaymobManager.makePayment(...);
      }

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment successful!')),
          );
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...paymentMethods.map((method) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: RadioListTile<String>(
                    value: method['id'],
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                    title: Text(method['name']),
                    secondary: Icon(method['icon']),
                  ),
                )),
            const Spacer(),
            ElevatedButton(
              onPressed: isLoading ? null : _handlePayment,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
