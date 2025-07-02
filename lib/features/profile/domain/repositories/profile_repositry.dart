import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/checkout/domain/entities/address_entity.dart';
import 'package:electro/features/profile/data/models/complaint_model.dart';
import 'package:electro/features/profile/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepositry {
  Future<Either<Failure, UserEntity>> getUserData( String userId);
  Future<void> updateUserData();
  Future<void> logout();
  Future<Either<Failure, void>> addcomplaint(ComplaintModel complaint);
  Future<Either<Failure, AddressEntity>> getUserAddress(String userId);
}