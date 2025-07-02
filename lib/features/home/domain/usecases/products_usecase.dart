import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class ProductsUsecase{
 final HomeRepositry homeRepositry;
  ProductsUsecase(this.homeRepositry);
  Future<Either<Failure, List<ProductEntity>>> call(String categoryid) async {
    var result = homeRepositry.getProducts( categoryid);
    return result;
  }

}