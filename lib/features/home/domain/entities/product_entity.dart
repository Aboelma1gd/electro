import 'package:electro/features/home/data/models/product_model.dart';
import 'package:electro/features/reviews/data/models/review_model.dart';
import 'package:electro/features/reviews/domain/entities/review_entity.dart';

class ProductEntity {
  final String name;
  final String productId;
  final String categoryId;
  final num price;
  final String image;
  int quantity;
  double ratingcount; 
  final List<String> sizes; 
  final String description;
  final List<String> colors; 
  final String category;
  final List<ReviewEntity> reviews;
  final int salescount;

  ProductEntity({
  required  this.salescount,
    required this.categoryId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.ratingcount,
    required this.sizes,
    required this.description,
    required this.colors,
    required this.category,
    required this.reviews,
  });

   // Convert ProductEntity to ProductModel
  ProductModel toModel() {
    return ProductModel(
      productId: productId,
      name: name,
      price: price,
      image: image,
      quantity: quantity,
      ratingcount: ratingcount,
      sizes: sizes,
      description: description,
      colors: colors,
      category: category,
      reviews: reviews.map((review) => ReviewModel(
        id: review.id,
        name: review.name,
        review: review.review,
        rating: review.rating, productId: productId, timestamp: review.timestamp,
        
      )).toList(),
      categoryId: categoryId, salescount: salescount,
    );
  }
}
