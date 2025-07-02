
import 'package:equatable/equatable.dart';
class CategoryEntity extends Equatable {
  final String id;
  final String image;
  final String title;
  final String productPath;

 const CategoryEntity({required this.image, required this.title, required this.productPath,required this.id});

  @override
  List<Object?> get props => [image, title, productPath, id];
}