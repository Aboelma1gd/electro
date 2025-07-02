import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class GetproductsBypriceUsecase {
  final HomeRepositry homeRepositry;
  GetproductsBypriceUsecase(this.homeRepositry);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    var result = homeRepositry.getSearchProductsByPrice();
    return result;
  }
}