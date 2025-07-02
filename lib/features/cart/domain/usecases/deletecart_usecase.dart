import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:electro/features/cart/domain/repositories/cart_repositry.dart';
import 'package:dartz/dartz.dart';

class DeletecartUsecase {
  final CartRepositry cartRepository;

  DeletecartUsecase(this.cartRepository);

  Future<Either<Failure, List<CartItemEntity>>> call(String cartId) async {
    return cartRepository.deletecart(cartId);
  }
}
