import 'package:electro/core/services/firebase_topsellingandnewin_services.dart';
import 'package:electro/core/services/firestore_services.dart';
import 'package:electro/features/home/data/models/product_model.dart';

abstract class RemoteProductdatasource {
  Future<List<ProductModel>> getremoteProducts(String categoryId);
  Future<List<ProductModel>> getnewinProducts();
  Future<List<ProductModel>> gettopsellingProducts();
}

class RemoteProductdatasourceImpl implements RemoteProductdatasource {
  final FirestoreService firestoreService;
  final FirebaseTopsellingandnewinServices firebaseTopsellingandnewinServices;

  RemoteProductdatasourceImpl(this.firestoreService, this.firebaseTopsellingandnewinServices);
  @override
  Future<List<ProductModel>> getremoteProducts(String categoryId) {
    return firestoreService.getProducts( categoryId);
  }
  @override
  Future<List<ProductModel>> getnewinProducts() {
    return firebaseTopsellingandnewinServices.getNewin();
  }
  
  @override
  Future<List<ProductModel>> gettopsellingProducts() {
    return firebaseTopsellingandnewinServices.getTopselling();
  }
}