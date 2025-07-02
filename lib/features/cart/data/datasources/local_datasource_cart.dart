import 'dart:convert';
import 'package:electro/features/cart/data/models/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';

abstract class LocalDatasourceCart {
  Future<List<CartItemModel>> getlocalcarts();
  Future<void> cacheCarts(List<CartItemModel> carts);
  Future<void> clearCarts();
}

class LocalDatasourceCartImpl implements LocalDatasourceCart {
  final SharedPreferences sharedPreferences;
  static const String CACHED_CARTS_KEY = 'cached_carts';

  LocalDatasourceCartImpl(this.sharedPreferences);

  @override
  Future<List<CartItemModel>> getlocalcarts() async {
    final String? cartsjson = sharedPreferences.getString(CACHED_CARTS_KEY);
    if (cartsjson != null) {
      List<dynamic> decodedList = json.decode(cartsjson);
      return decodedList.map((cart) => CartItemModel.fromJson(cart)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheCarts(List<CartItemModel> carts) async {
    final cartsJson = json.encode(carts.map((cart) => cart.toJson()).toList());
    await sharedPreferences.setString(CACHED_CARTS_KEY, cartsJson);
  }

  @override
  Future<void> clearCarts() async {
    await sharedPreferences.remove(CACHED_CARTS_KEY);
  }

  bool hasCachedData() {
    final String? categoriesJson =
        sharedPreferences.getString(CACHED_CARTS_KEY);
    return categoriesJson != null && categoriesJson.isNotEmpty;
  }
}
