import 'package:bloc/bloc.dart';
import 'package:electro/features/authintication/domain/usecases/forgetpassword_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'forgetpasswordreset_state.dart';

class ForgetpasswordresetCubit extends Cubit<ForgetpasswordresetState> {
  final ForgetpasswordUsecase forgetpasswordUsecase;
  final emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  ForgetpasswordresetCubit(this.forgetpasswordUsecase) : super(ForgetpasswordresetInitial());

  Future<void> forgetpassword(String email) async {
    emit(ForgetpasswordresetLoading());
    final result = await forgetpasswordUsecase.call(email);
    result.fold((failure) => emit(ForgetpasswordresetError(message: failure.message)),
        (r) => emit(const ForgetpasswordresetSuccess(message: 'Password reset email sent successfully')));
  }
}
