import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/profile/domain/entities/user_entity.dart';
import 'package:electro/features/profile/domain/repositories/profile_repositry.dart';
import 'package:dartz/dartz.dart';

class ProfileUsecase {
  final ProfileRepositry profileRepositry;
  ProfileUsecase({required this.profileRepositry});

  Future<Either<Failure, UserEntity>> getUserData( String userId) => profileRepositry.getUserData(userId);
  Future<void> logout() => profileRepositry.logout();
}