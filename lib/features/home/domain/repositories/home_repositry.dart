import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/home/domain/entities/category_entity.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepositry {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<ProductEntity>>> getProducts(String categoryid);
  Future<Either<Failure, List<ProductEntity>>> getTopSeelingProducts();
  Future<Either<Failure, List<ProductEntity>>> getNewProducts();
  Future<Either<Failure, List<ProductEntity>>> getproductsbytitle(String title);
    Future<Either<Failure, List<ProductEntity>>> getAllproducts(String query);
    Future<Either<Failure, List<ProductEntity>>> getSearchProductsByPrice();
}
