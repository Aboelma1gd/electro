import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class Getproductsbytitle {
  final HomeRepositry homeRepositry;

  Getproductsbytitle(this.homeRepositry);

  Future<Either<Failure, List<ProductEntity>>> call(String title) {
    var result = homeRepositry.getproductsbytitle(title);
    return result;
  }
}