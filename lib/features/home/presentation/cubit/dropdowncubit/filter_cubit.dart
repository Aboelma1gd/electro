import 'package:electro/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FilterCubit extends Cubit<String?> {
  final ProductsCubit productsCubit;
  String currentSearchQuery = "";

  FilterCubit(this.productsCubit) : super(null);

 void setFilter({String? price, String? searchQuery}) {
  if (searchQuery != null) {
    currentSearchQuery = searchQuery;
  }
  if (price != null) {
    emit(price);
    productsCubit.getProductsByPrice(price, currentSearchQuery);
  } else {
    productsCubit.getAllProducts(currentSearchQuery);
  }
}

}
