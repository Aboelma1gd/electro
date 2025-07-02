import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/authintication/domain/entities/signup_entity.dart';
import 'package:electro/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:dartz/dartz.dart';

class Authusecase  {
  final AuthRepositries authRepositries;

  Authusecase(this.authRepositries);


  Future<Either<Failure, SignupEntity>> call(SignupEntity signupentity) async{
    return await authRepositries.signup(signupentity);
  }
}
