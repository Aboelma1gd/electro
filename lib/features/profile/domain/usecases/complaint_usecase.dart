import 'package:electro/core/errors/failure.dart';
import 'package:electro/core/usecases/authusecase.dart';
import 'package:electro/features/profile/domain/repositories/profile_repositry.dart';
import 'package:dartz/dartz.dart';

class ComplaintUsecase implements UseCases{
  final ProfileRepositry profileRepositry;
  ComplaintUsecase(this.profileRepositry);
  @override
  Future<Either<Failure, void>> call(params) {
    return profileRepositry.addcomplaint(params);
  }

}