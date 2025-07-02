import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/home/domain/entities/category_entity.dart';
import 'package:electro/features/home/domain/repositories/home_repositry.dart';
import 'package:dartz/dartz.dart';

class CategoryUsecase  {
  final HomeRepositry homeRepositry;

  CategoryUsecase(this.homeRepositry);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    var result = homeRepositry.getCategories();
    return result;
  }
}
