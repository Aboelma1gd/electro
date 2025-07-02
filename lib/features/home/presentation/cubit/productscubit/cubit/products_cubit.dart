import 'package:bloc/bloc.dart';
import 'package:electro/features/home/data/models/product_model.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:electro/features/home/domain/usecases/getproducts_byprice_usecase.dart';
import 'package:electro/features/home/domain/usecases/products_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ProductsUsecase productsUseCase;
  final GetAllProductsUsecase getAllProductsUsecase;
  final GetproductsBypriceUsecase getproductsBypriceUsecase;
  ProductsCubit(this.productsUseCase, this.getAllProductsUsecase,
      this.getproductsBypriceUsecase)
      : super(ProductsInitial());

  Future<void> getProducts(String categoryid) async {
    emit(ProductsLoading());
    var result = await productsUseCase.call(categoryid);
    result.fold((l) => emit(ProductsError(message: l.message)),
        (r) => emit(ProductsLoaded(products: r)));
  }

  Future<void> getAllProducts(String query) async {
    emit(ProductsLoading());
    var result = await getAllProductsUsecase.call(query);
    result.fold(
      (l) => emit(ProductsError(message: l.message)),
      (r) {
        print("✅ المنتجات المحملة: ${r.length}");
        emit(ProductsLoaded(products: r));
      },
    );
  }

  Future<void> getProductsByPrice(
      String priceFilter, String searchQuery) async {
    emit(ProductsLoading());
    try {
      Query query = firestore.collection('Allproducts');

      // تصفية النتائج بناءً على البحث بالاسم
      if (searchQuery.isNotEmpty) {
        query = query
            .where('name', isGreaterThanOrEqualTo: searchQuery)
            .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff');
      }

      // تطبيق الفلترة الخاصة بالسعر
      if (priceFilter == "Low to High") {
        query = query.orderBy('price', descending: false).orderBy('name');
      } else if (priceFilter == "High to Low") {
        query = query.orderBy('price', descending: true).orderBy('name');
      } else if (priceFilter == "Discount") {
        query = query.where('discount', isEqualTo: true);
      }

      final querySnapshot = await query.get();
      final products = querySnapshot.docs
          .map((doc) =>
              ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      print(
          "✅ Filtered products loaded: ${products.length} for priceFilter: $priceFilter, searchQuery: $searchQuery");
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(const ProductsError(message: "Failed to filter products"));
    }
  }

  Future<void> incrementSalesCount(String productId) async {
    try {
      DocumentReference productRef =
          firestore.collection('Allproducts').doc(productId);

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(productRef);

        if (!snapshot.exists) {
          throw Exception("المنتج غير موجود!");
        }

        int currentSalesCount = snapshot['salescount'] ?? 0;
        transaction.update(productRef, {'salescount': currentSalesCount + 1});
      });

      print("✅ تم تحديث salescount للمنتج: $productId");
    } catch (e) {
      print("❌ خطأ أثناء تحديث salescount: $e");
    }
  }
}
