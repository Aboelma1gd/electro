part of 'cart_cubit.dart';

abstract class CartState  {
  const CartState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> cartItems;
  const CartLoaded(this.cartItems);
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
}

class DeleteFromCart extends CartState{
  final CartItemEntity cartItemEntity;
  const DeleteFromCart(this.cartItemEntity);
}

class CartQuantityandTotalpriceUpdated extends CartState {
   final String newQuantity;
   final double totalPrice;
  const CartQuantityandTotalpriceUpdated(this.newQuantity, this.totalPrice);
}

class Addtocart extends CartState {
  final CartItemEntity cartItem;
  const Addtocart(this.cartItem);
}

class CartUpdated extends CartState {
  final List<CartItemEntity> cart;
  const CartUpdated(this.cart);
}

