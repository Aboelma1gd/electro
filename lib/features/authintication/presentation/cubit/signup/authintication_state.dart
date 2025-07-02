// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authintication_cubit.dart';

abstract class AuthinticationState extends Equatable {
  const AuthinticationState();

  @override
  List<Object> get props => [];
}

class AuthinticationInitial extends AuthinticationState {}

class AuthinticationLoading extends AuthinticationState {}

class AuthinticationSuccess extends AuthinticationState {
 // final SignupEntity signupEntity;
  //const AuthinticationSuccess({required this.signupEntity});
}

class AuthinticationFailure extends AuthinticationState {
  final String message;
  const AuthinticationFailure({required this.message});
}

class Authinticationvisibility extends AuthinticationState {
  final bool isobsecure;
  const Authinticationvisibility(this.isobsecure);

  @override
  List<Object> get props => [isobsecure];  // إضافة `props` لإجبار Bloc على التحديث
}
