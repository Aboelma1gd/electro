import 'package:bloc/bloc.dart';
import 'package:electro/features/authintication/domain/entities/signup_entity.dart';
import 'package:electro/features/authintication/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'authintication_state.dart';

class AuthinticationCubit extends Cubit<AuthinticationState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Authusecase authusecase;

  bool isPasswordVisible = true;
  AuthinticationCubit(this.authusecase) : super(AuthinticationInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(Authinticationvisibility(isPasswordVisible));
  }

  Future<void> signup(SignupEntity signupentity) async {
    emit(AuthinticationLoading());

    final result = await authusecase(signupentity);

    result.fold(
      (failure) => emit(AuthinticationFailure(message: failure.message)),
      (signupModel) => emit(AuthinticationSuccess()),
    );
  }
}
