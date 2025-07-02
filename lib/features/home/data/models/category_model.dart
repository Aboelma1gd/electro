import 'package:electro/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel(
     {
    required super.image,
    required super.title, required super.productPath, required super.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json,) {
    return CategoryModel(
      image: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      productPath: json['productPath'] ?? '', id:json['categoryId'] , // قراءة المسار من JSON
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryId': id,
        'imageUrl': image,
        'title': title,
        'productPath': productPath, // تضمين المسار في JSON
      };
}