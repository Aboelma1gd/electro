import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/authintication/domain/entities/login_entity.dart';
import 'package:electro/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase{
  final AuthRepositries authRepositries;
  LoginUsecase(this.authRepositries);
  Future<Either<Failure, LoginEntity>> call(LoginEntity params) async{
    return await authRepositries.login(params);
  }
}