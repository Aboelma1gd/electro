import 'package:electro/features/home/data/models/product_model.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<ProductModel> products;
  FilterLoaded(this.products);
}

class FilterError extends FilterState {
  final String message;
  FilterError(this.message);
}
