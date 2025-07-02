import 'package:electro/core/errors/failure.dart';
import 'package:electro/core/network/network_info.dart';
import 'package:electro/core/services/firebase_add_services.dart';
import 'package:electro/features/cart/data/datasources/local_datasource_cart.dart';
import 'package:electro/features/cart/data/datasources/remote_datasource_cart.dart';
import 'package:electro/features/cart/data/models/cart_item_model.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:electro/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepositryImpl extends CartRepositry {
  final RemoteDatasourceCart remoteDatasourceCart;
  final LocalDatasourceCart localDatasourceCart;
  final NetworkInfo networkInfo;
  final FirebaseAddServices firebaseAddServices;

  CartRepositryImpl(this.networkInfo, this.firebaseAddServices,
      {required this.remoteDatasourceCart, required this.localDatasourceCart});

  @override
  Future<Either<Failure, List<CartItemEntity>>> getcarts() async {
    if (await networkInfo.isConnected) {
      final prefs = await SharedPreferences.getInstance();
      final lastUserId = prefs.getString('last_user_id');
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && lastUserId != currentUser.uid) {
        await localDatasourceCart.clearCarts();
        await prefs.setString('last_user_id', currentUser.uid);
      }

      return _fetchRemoteCarts();
    }
    return _getLocalCarts();
  }

  Future<Either<Failure, List<CartItemEntity>>> _fetchRemoteCarts() async {
    try {
      final carts = await remoteDatasourceCart.getCart();
      await localDatasourceCart.cacheCarts(carts);
      return Right(carts.map((cart) => cart.toEntity()).toList());
    } catch (e) {
      return await _getLocalCarts();
    }
  }

  Future<Either<Failure, List<CartItemEntity>>> _getLocalCarts() async {
    try {
      final carts = await localDatasourceCart.getlocalcarts();
      if (carts.isEmpty) {
        return const Left(CacheFailure('No cached data available'));
      }
      return Right(carts.map((cart) => cart.toEntity()).toList());
    } catch (e) {
      return Left(
          CacheFailure('Failed to retrieve cached data: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CartItemEntity>> addtocart(
      CartItemEntity cartItem, String userId) async {
    try {
      final CartItemModel cartItemModel = CartItemModel(
        selectedColor: cartItem.selectedColor,
        selectedSize: cartItem.selectedSize,
        quantity: cartItem.quantity,
        totalPrice: cartItem.totalPrice,
        name: cartItem.name,
        image: cartItem.image,
        price: cartItem.price,
        id: cartItem.id,
      );
      await firebaseAddServices.addCartItem(cartItemModel, userId);
      return Right(cartItem);
    } catch (e) {
      return Left(
          CacheFailure('Failed to add product to cart: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemEntity>>> deletecart(
      String cartId) async {
    try {
      await firebaseAddServices.deletecart(cartId);
      return const Right([]);
    } catch (e) {
      return Left(
          CacheFailure('Failed to delete product from cart: ${e.toString()}'));
    }
  }
}
