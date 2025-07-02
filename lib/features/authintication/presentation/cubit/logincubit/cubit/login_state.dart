part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {

}

final class LoginFailure extends LoginState {
  final String message;
  const LoginFailure({required this.message});
}


class Loginvisibility extends LoginState {
  final bool isobsecure;
  const Loginvisibility(this.isobsecure);

  @override
  List<Object> get props => [isobsecure];  // إضافة `props` لإجبار Bloc على التحديث
}


