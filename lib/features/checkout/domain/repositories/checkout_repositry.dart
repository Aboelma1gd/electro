import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/checkout/data/models/address_model.dart';
import 'package:electro/features/checkout/domain/entities/address_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepositry {
 Future<Either<Failure, AddressEntity>> addAddress(AddressModel address, String userid);
 Future<Either<Failure, AddressEntity>> getUserAddress(String userId);
}