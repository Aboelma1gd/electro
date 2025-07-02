import 'package:electro/features/home/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTopsellingandnewinServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getTopselling() async {
    try {
      final result = await firestore
          .collection('Allproducts')
          .where('salescount', isGreaterThanOrEqualTo: 5)
          .orderBy('salescount', descending: true)
          .limit(10)
          .get();
      print("✅ المنتجات المحملة: ${result.docs.length}");
      return result.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

  Future<List<ProductModel>> getNewin() async {
    try {
      final result = await firestore
          .collection('Allproducts')
          .where('createdate',
              isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()
                      .subtract(const Duration(
                          days: 90)) // Show products from last 3 months
                  ))
          .orderBy('createdate', descending: true)
          .limit(10)
          .get();
      return result.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
