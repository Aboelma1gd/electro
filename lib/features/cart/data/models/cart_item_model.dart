import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  final String selectedSize;
  final String selectedColor;

  const CartItemModel({
    required super.quantity,
    required super.totalPrice,
    required super.name,
    required super.image,
    required super.price,
    required super.id,
    required this.selectedSize,
    required this.selectedColor,
  }) : super(
          selectedSize: selectedSize,
          selectedColor: selectedColor,
        );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      quantity: json['quantity'] ?? 1,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num).toDouble(),
      id: json['id'] ?? '',
      selectedSize: json['selectedSize'] ?? '',
      selectedColor: json['selectedColor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'totalPrice': totalPrice,
      'name': name,
      'image': image,
      'price': price,
      'id': id,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      quantity: quantity,
      totalPrice: totalPrice,
      name: name,
      image: image,
      price: price,
      id: id,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
    );
  }
}
