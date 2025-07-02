import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class GetTopsellingProducts {
  final HomeRepositry homeRepositry;
  GetTopsellingProducts(this.homeRepositry);
  Future<Either<Failure, List<ProductEntity>>> call() async {
    var result = homeRepositry.getTopSeelingProducts();
    return result;
  }
}