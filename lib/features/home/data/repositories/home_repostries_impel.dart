import 'package:electro/core/errors/failure.dart';
import 'package:electro/core/network/network_info.dart';
import 'package:electro/core/services/firestore_services.dart';
import 'package:electro/features/home/data/datasources/category_datasources/local_datasource.dart';
import 'package:electro/features/home/data/datasources/category_datasources/remote_datasource.dart';
import 'package:electro/features/home/data/datasources/product_datasources/local_productdatasource.dart';
import 'package:electro/features/home/data/datasources/product_datasources/remote_productdatasource.dart';
import 'package:electro/features/home/data/models/category_model.dart';
import 'package:electro/features/home/data/models/product_model.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class HomeRepostriesImpel extends HomeRepositry {
  final NetworkInfo networkInfo;
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;
  final LocalProductdatasource localProductdatasource;
  final RemoteProductdatasource remoteProductdatasource;
  final FirestoreService firestoreService;

  HomeRepostriesImpel(
    this.networkInfo,
    this.remoteDatasource,
    this.localDatasource,
    this.localProductdatasource,
    this.remoteProductdatasource, this.firestoreService,
  );

  /// ✅ جلب الفئات (Categories)
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      if (await networkInfo.isConnected) {
        return await _fetchRemoteCategories();
      } else {
        return await _getLocalCategories();
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch categories: ${e.toString()}'));
    }
  }

  /// 🔹 دالة خاصة لجلب البيانات من Firestore
  Future<Either<Failure, List<CategoryModel>>> _fetchRemoteCategories() async {
    try {
      final categories = await remoteDatasource.getCategories();
      await localDatasource.cacheCategories(categories); // Cache البيانات
      return Right(categories);
    } catch (e) {
      return await _getLocalCategories(); // في حالة فشل الـ API، نحاول من الكاش
    }
  }

  /// 🔹 دالة خاصة لجلب البيانات من الكاش
  Future<Either<Failure, List<CategoryModel>>> _getLocalCategories() async {
    try {
      final categories = await localDatasource.getLastCategories();
      if (categories.isEmpty) {
        return const Left(CacheFailure('No cached data available'));
      }
      return Right(categories);
    } catch (e) {
      return Left(CacheFailure('Failed to retrieve cached data: ${e.toString()}'));
    }
  }

  /// -----------------------------------------------------------------------------✅ جلب المنتجات (Products)
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(String categoryid) async {
    return await _fetchProducts(   categoryid );
  }

  /// 🔹 دالة خاصة لجلب المنتجات من الـ API أو الكاش
  Future<Either<Failure, List<ProductEntity>>> _fetchProducts(String categoryid) async {
    if (await networkInfo.isConnected) {
      return await _fetchRemoteProducts(  categoryid );
    } else {
      return await _fetchLocalProducts();
    }
  }

  /// 🔹 جلب المنتجات من Firestore
  Future<Either<Failure, List<ProductEntity>>> _fetchRemoteProducts(String categoryid) async {
    try {
      List<ProductModel> products =
          await remoteProductdatasource.getremoteProducts(categoryid );
      return Right(products); // ✅ لا حاجة لتحويل `ProductModel` إلى `ProductEntity` لأنه يرثها
    } catch (e) {
      return Left(ServerFailure('Server error: ${e.toString()}'));
    }
  }

  /// 🔹 جلب المنتجات من الكاش
  Future<Either<Failure, List<ProductEntity>>> _fetchLocalProducts() async {
    try {
      List<ProductModel> products = await localProductdatasource.getlocalProducts();
      return Right(products);
    } catch (e) {
      return Left(CacheFailure('Cache error: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getTopSeelingProducts() async{
    try {
      final products = await remoteProductdatasource.gettopsellingProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>>getNewProducts () async{
    try {
      final products = await remoteProductdatasource.getnewinProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getproductsbytitle(String title) async{
     try {
       final products = await  firestoreService.getproductsBytitle(title);
       return Right(products);
     } catch (e) {
       return Left(ServerFailure(e.toString()));
     }
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllproducts( String query) async{
  try {
    final products = await firestoreService.getallproducts( query);
    return Right(products);
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getSearchProductsByPrice() async{
    try {
      final products = await firestoreService.getSearchProductsByPrice();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
