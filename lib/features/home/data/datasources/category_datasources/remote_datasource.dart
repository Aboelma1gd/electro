import 'package:electro/core/services/firestore_services.dart';
import 'package:electro/features/home/data/models/category_model.dart';

abstract class RemoteDatasource {
  Future<List<CategoryModel>> getCategories();
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final FirestoreService firestoreService;

  RemoteDatasourceImpl(this.firestoreService);

  @override
  Future<List<CategoryModel>> getCategories() {
    return firestoreService.getCategories();
  }
}
