// ignore_for_file: file_names

import 'package:electro/core/errors/failure.dart';
import 'package:electro/core/services/firebase_add_services.dart';
import 'package:electro/features/checkout/data/models/address_model.dart';
import 'package:electro/features/checkout/domain/entities/address_entity.dart';
import 'package:electro/features/checkout/domain/repositories/checkout_repositry.dart';
import 'package:dartz/dartz.dart';

class CheckoutRepositriesImpl extends CheckoutRepositry{
  final FirebaseAddServices _firebaseAddServices = FirebaseAddServices();
  @override
  Future<Either<Failure, AddressEntity>> addAddress(AddressModel address, String userid) async {
    try {
      await _firebaseAddServices.addAddress(address, userid);
      return Right(address);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, AddressEntity>> getUserAddress(String userId) async{
    try {
      final address = await _firebaseAddServices.getUserAddress(userId);
      return Right(address);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}