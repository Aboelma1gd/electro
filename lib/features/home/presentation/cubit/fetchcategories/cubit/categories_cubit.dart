import 'package:bloc/bloc.dart';
import 'package:electro/features/home/domain/entities/category_entity.dart';
import 'package:electro/features/home/domain/usecases/category_usecase.dart';
import 'package:equatable/equatable.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryUsecase categoryUsecase;
  CategoriesCubit(this.categoryUsecase) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final result = await categoryUsecase.homeRepositry.getCategories();
    result.fold((l) => emit(CategoriesError(message: l.message)), (r) => emit(CategoriesLoaded(categories: r)));
  }
}
