import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/checkout/domain/entities/address_entity.dart';
import 'package:electro/features/profile/domain/repositories/profile_repositry.dart';
import 'package:dartz/dartz.dart';

class GetaddressUsecase {
  final ProfileRepositry profileRepositry;
  GetaddressUsecase(this.profileRepositry);

  Future<Either<Failure, AddressEntity>> call(String userId) {
    return profileRepositry.getUserAddress(userId);
  }
}