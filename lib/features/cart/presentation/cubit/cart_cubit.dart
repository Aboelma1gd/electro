import 'package:electro/features/cart/domain/usecases/deletecart_usecase.dart';
import 'package:electro/features/cart/domain/usecases/getcarts_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:electro/features/cart/domain/usecases/addcart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddcartUsecase addcartUsecase;
  final GetcartsUsecase getcartsUsecase;
  final DeletecartUsecase deletecartUsecase;

  CartCubit(this.addcartUsecase, this.getcartsUsecase, this.deletecartUsecase)
      : super(CartInitial()) {
    getcarts();
  }

  List<CartItemEntity> _cartItems = [];
  List<CartItemEntity> get cartItems => _cartItems;

  /// 🔹 دالة لحساب السعر الإجمالي بناءً على السعر والكمية
  double calculateUpdatedTotalPrice(double price, int quantity) {
    return price * quantity;
  }

  /// 🔹 دالة لتحديث العنصر داخل السلة وإعادة الإرسال للحالة
  void updateCartItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length) {
      final cart = _cartItems[index];
      double updatedTotalPrice =
          calculateUpdatedTotalPrice(cart.price, newQuantity);

      _cartItems[index] = cart.copyWith(
        quantity: newQuantity,
        totalPrice: updatedTotalPrice,
      );
      emit(CartLoaded(_cartItems));
    }
  }

  Future<void> addToCart(CartItemEntity cart, String userId) async {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.id == cart.id);

    if (existingItemIndex != -1) {
      final existingItem = _cartItems[existingItemIndex];
      int updatedQuantity = existingItem.quantity + cart.quantity;
      double updatedTotalPrice =
          calculateUpdatedTotalPrice(existingItem.price, updatedQuantity);

      final updatedItem = existingItem.copyWith(
        quantity: updatedQuantity,
        totalPrice: updatedTotalPrice,
      );

      final result = await addcartUsecase.call(updatedItem, userId);
      result.fold(
        (failure) => emit(CartError(failure.message)),
        (cartItem) {
          _cartItems[existingItemIndex] = cartItem;
          emit(CartLoaded(_cartItems));
        },
      );
    } else {
      final result = await addcartUsecase.call(cart, userId);
      result.fold(
        (failure) => emit(CartError(failure.message)),
        (cartItem) {
          _cartItems.add(cartItem);
          emit(CartLoaded(_cartItems));
        },
      );
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      updateCartItemQuantity(index, _cartItems[index].quantity + 1);
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 &&
        index < _cartItems.length &&
        _cartItems[index].quantity > 1) {
      updateCartItemQuantity(index, _cartItems[index].quantity - 1);
    }
  }

  void updateQuantity(int index, int additionalQuantity) {
    if (index >= 0 && index < _cartItems.length) {
      updateCartItemQuantity(
          index, _cartItems[index].quantity + additionalQuantity);
    }
  }

  Future<void> getcarts() async {
    emit(CartLoading());
    final result = await getcartsUsecase.call();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) {
        _cartItems = items;
        emit(CartLoaded(_cartItems));
      },
    );
  }

  Future<void> deletecart(String cartId) async {
    final itemIndex = _cartItems.indexWhere((item) => item.id == cartId);

    if (itemIndex != -1) {
      final removedItem = _cartItems[itemIndex];
      _cartItems.removeAt(itemIndex);
      emit(CartLoaded(_cartItems));

      final result = await deletecartUsecase.call(cartId);
      result.fold(
        (failure) {
          _cartItems.insert(itemIndex, removedItem);
          emit(CartError(failure.message));
          emit(CartLoaded(_cartItems));
        },
        (_) {},
      );
    }
  }

  Future<void> clearCart() async {
    if (_cartItems.isEmpty) return;

    final oldCartItems = List<CartItemEntity>.from(_cartItems);
    _cartItems.clear();
    emit(CartLoaded(_cartItems));

    for (var item in oldCartItems) {
      final result = await deletecartUsecase.call(item.id.toString());
      result.fold(
        (failure) {
          _cartItems.addAll(oldCartItems);
          emit(CartError(failure.message));
          emit(CartLoaded(_cartItems));
          return;
        },
        (_) {},
      );
    }
  }

  @override
  Future<void> close() {
    _cartItems.clear();
    return super.close();
  }
}
