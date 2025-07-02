import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepositry {
  Future<Either<Failure, List<CartItemEntity>>> getcarts();
  Future<Either<Failure, List<CartItemEntity>>> deletecart(String cartId);

  Future<Either<Failure, CartItemEntity>> addtocart(
      CartItemEntity cartItem, String userId);
}
