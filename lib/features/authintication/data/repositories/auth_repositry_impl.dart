import 'package:electro/core/errors/failure.dart';
import 'package:electro/core/services/firebase_auth_services.dart';
import 'package:electro/features/authintication/data/models/login_model.dart';
import 'package:electro/features/authintication/data/models/signup_model.dart';
import 'package:electro/features/authintication/domain/entities/login_entity.dart';
import 'package:electro/features/authintication/domain/entities/signup_entity.dart';
import 'package:electro/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class AuthRepositryImpl extends AuthRepositries {
  final FirebaseAuthServices firebaseAuthServices;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  AuthRepositryImpl({required this.firebaseAuthServices});

  @override
  Future<Either<Failure, SignupEntity>> signup(SignupEntity signupentity) async {
    try {
      String userId = await firebaseAuthServices.createNewUser(
        signupentity.email, 
        signupentity.password
      );

      SignupModel signupModel = SignupModel(
        firstname: signupentity.firstname,
        lastname: signupentity.lastname,
        email: signupentity.email,
        password: signupentity.password,
        userId,
      );

      await users.doc(userId).set({
        'userId': userId,
        'firstName': signupModel.firstname,
        'lastName': signupModel.lastname,
        'email': signupModel.email,
      });

      return Right(signupModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(LoginEntity loginentity) async {
    try {
      LoginModel loginModel = LoginModel(email: loginentity.email, password: loginentity.password);
      await firebaseAuthServices.signInUser(loginentity.email, loginentity.password);
      return Right(loginModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPasswordrepo(String email) async {
    try {
      await firebaseAuthServices.forgetPasswordService(email);
      return const Right("Password reset email sent successfully");
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async{
   try {
    bool isLoggeddIn= await firebaseAuthServices.isLoggedIn();
     return  Right(isLoggeddIn);
   } catch (e) {
     return  Left(Failure(e.toString()));
   }
  }

}
