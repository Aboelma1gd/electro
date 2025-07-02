import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/authintication/domain/entities/login_entity.dart';
import 'package:electro/features/authintication/domain/entities/signup_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositries {
  Future<Either<Failure, SignupEntity>> signup(SignupEntity signupEntity);
  Future<Either<Failure, LoginEntity>> login(LoginEntity loginentity);
  Future<Either<Failure, String>> forgotPasswordrepo(String email);
  Future<Either<Failure,bool>> isLoggedIn();
}