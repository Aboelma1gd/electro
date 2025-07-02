import 'package:electro/features/payments/paymob_constants.dart';
import 'package:dio/dio.dart' as dio;

class PaymobManager {
   Future<String> getPaymentKey(int amount, String currency) async {
  try {
      String AuthinticationToken = await _getAuthToken();
    int orderId = await _getorderId(AuthinticationToken: AuthinticationToken, amount: (amount * 100).toString(), currency: currency);
    String paymentkey =await _getPaymentKey(
      AuthinticationToken: AuthinticationToken,
      amount: (amount * 100).toString(),
      currency: currency,
      orderId: orderId.toString(),
    );
    return paymentkey;
  } catch (e) {
    throw Exception('Failed to get payment key: $e');
  }
  }

  Future <String> _getAuthToken() async {
  final dio.Response response = await dio.Dio().post(
      'https://accept.paymob.com/api/auth/tokens',
      data: {
       'api_key': PaymobConstants().apikey
      },
    );
     return response.data['token'];
  }

  Future<int> _getorderId({
    required String AuthinticationToken,
    required String amount,
    required String currency 
  }) async{
   final dio.Response response = await dio.Dio().post(
       'https://accept.paymob.com/api/ecommerce/orders',
       data: {
         'auth_token': AuthinticationToken,
         'delivery_needed': 'false',
         'amount_cents': amount,
         'currency': currency,
         'items': [
           {
             'name': 'T-shirt',
             'quantity': 1,
             'unit_price_cents': 100
           }
         ]

       },
       
   );
   return response.data['id'];
  }
  
  Future<String> _getPaymentKey({
    required String AuthinticationToken,
    required String amount,
    required String currency,
    required String orderId
  }) async{
    final dio.Response response = await dio.Dio().post(
        'https://accept.paymob.com/api/acceptance/payment_keys',
        data: {
          'expiration': 3600,
          'integration_id': PaymobConstants().integrationId,
          'auth_token': AuthinticationToken,
          'amount_cents': amount,
          'currency': currency,
          'order_id': orderId,
          'billing_data': {
            'apartment': '1',
            'email': 'a@b.com',
            'floor': '1',
            'first_name': 'Ahmed',
            'street': 'Elnour',
            'building': '1',
            'phone_number': '01012345678',
            'shipping_method': 'UPS',
            'city': 'Cairo',
            'country': 'Egypt',
            'postal_code': '12345',
            'last_name': 'Mohamed',
            'state': 'Cairo'
          }
        },
    );
    return response.data['token'];
  }
}