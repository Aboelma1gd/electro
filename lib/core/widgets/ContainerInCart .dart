import 'package:flutter/material.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';

class ContainerInCart extends StatelessWidget {
  final CartItemEntity cartItemEntity;
  final VoidCallback onRemove;

  const ContainerInCart({
    Key? key,
    required this.cartItemEntity,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cartItemEntity.name),
        subtitle: Text('Size: ${cartItemEntity.selectedSize}, Color: ${cartItemEntity.selectedColor}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
