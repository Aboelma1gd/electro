import 'dart:convert';
import 'package:electro/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalProductdatasource {
  Future<List<ProductModel>> getlocalProducts();
   Future<void> cacheproducts(List<ProductModel> categories);
}

class LocalProductdatasourceImpl implements LocalProductdatasource {
  final SharedPreferences sharedPreferences;

  LocalProductdatasourceImpl({required this.sharedPreferences});
  
  @override
  Future<void> cacheproducts(List<ProductModel> products) async {
       final productsJson =json.encode(products.map((product) => product.toJson()).toList());
    await sharedPreferences.setString('products', productsJson);
  }
  
  @override
  Future<List<ProductModel>> getlocalProducts() async{
    final String? productsjson = sharedPreferences.getString('products');
    if (productsjson != null) {
      List<dynamic> decodedList = json.decode(productsjson);
      return decodedList
          .map((product) => ProductModel.fromJson(product, product['id']))
          .toList();
    } else {
      return [];
    }
  }
}