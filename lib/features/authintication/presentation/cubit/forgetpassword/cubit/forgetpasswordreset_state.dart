part of 'forgetpasswordreset_cubit.dart';

sealed class ForgetpasswordresetState extends Equatable {
  const ForgetpasswordresetState();

  @override
  List<Object> get props => [];
}

final class ForgetpasswordresetInitial extends ForgetpasswordresetState {}

final class ForgetpasswordresetLoading extends ForgetpasswordresetState {}

final class ForgetpasswordresetError extends ForgetpasswordresetState {
  final String message;
  const ForgetpasswordresetError({required this.message});
}

final class ForgetpasswordresetSuccess extends ForgetpasswordresetState {
  final String message;
  const ForgetpasswordresetSuccess({required this.message});
}
