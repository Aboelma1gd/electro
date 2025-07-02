import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double totalPrice;
  final double price;
  final String selectedSize;
  final String selectedColor;

  const CartItemEntity({
    required this.name,
    required this.image,
    required this.quantity,
    required this.totalPrice,
    required this.price,
    required this.id,
    required this.selectedSize,
    required this.selectedColor,
  });

  @override
  List<Object?> get props => [
        name,
        image,
        quantity,
        totalPrice,
        price,
        id,
        selectedSize,
        selectedColor
      ];

  CartItemEntity copyWith({
    String? name,
    String? image,
    int? quantity,
    double? totalPrice,
    double? price,
    String? id,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItemEntity(
      name: name ?? this.name,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      price: price ?? this.price,
      id: id ?? this.id,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  static CartItemEntity empty() {
    return CartItemEntity(
      id: '',
      name: '',
      image: '',
      quantity: 0,
      totalPrice: 0.0,
      price: 0.0,
      selectedSize: '',
      selectedColor: '',
    );
  }
}
