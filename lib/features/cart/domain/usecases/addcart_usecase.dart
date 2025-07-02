import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:electro/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';

class AddcartUsecase {
  final CartRepositry cartRepository;

  AddcartUsecase(this.cartRepository);

  Future<Either<Failure, CartItemEntity>> call(CartItemEntity cart, String userId) async {
    return cartRepository.addtocart(cart, userId);
  }
}