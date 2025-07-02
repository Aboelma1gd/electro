import 'package:bloc/bloc.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/domain/usecases/get_topselling_products.dart';
import 'package:electro/features/home/domain/usecases/new_products_usecase.dart';
import 'package:equatable/equatable.dart';

part 'topsellingandnewin_state.dart';

class TopsellingandnewinCubit extends Cubit<TopsellingandnewinState> {
  final GetTopsellingProducts getTopsellingProducts;
  final NewProductsUsecase newProductsUsecase;
  TopsellingandnewinCubit(this.getTopsellingProducts, this.newProductsUsecase) : super(TopsellingandnewinInitial());

   Future<void> getNewProducts() async {
    emit(TopsellingandnewinLoading());
    var result = await newProductsUsecase.call();
    result.fold((l) => emit(TopsellingandnewinError( l.message)), (r) => emit(TopsellingandnewinLoaded(  r)));
  }

  Future<void> gettopsellingproduct() async {
    emit(TopsellingandnewinLoading());
    var result = await getTopsellingProducts.call();
    result.fold((l) => emit(TopsellingandnewinError( l.message)), (r) => emit(TopsellingandnewinLoaded( r)));
  }
}
