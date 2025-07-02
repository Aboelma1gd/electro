part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}


class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}
class AddadressLoaded extends CheckoutState {
  final AddressEntity address;
  const AddadressLoaded(this.address);
}
class AddadressError extends CheckoutState {
  final String message;
  const AddadressError(this.message);
}

class CheckoutError extends CheckoutState {
  final String message;
  const CheckoutError(this.message);
}
