import 'package:electro/config/routing/routes.dart';
import 'package:electro/features/home/presentation/widgets/category_loding_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:electro/features/home/presentation/widgets/texts_in_homeview.dart';
import 'package:electro/features/home/presentation/widgets/category_list.dart';
import 'package:go_router/go_router.dart';

class HomeCategories extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const HomeCategories({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
   final categoriesCubit = context.read<CategoriesCubit>(); // استخدم الكيوبت الموجود بالفعل
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NewWidget(),
        SizedBox(height: screenHeight * 0.026),
        SizedBox(
          height: screenHeight * 0.12,
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            bloc: categoriesCubit,
            // bloc: categoriesCubit, // استخدم نفس الكيوبت
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return CategoryLoadingShimmer(
                screenWidth: screenWidth,
                 screenHeight: screenHeight,
                );
           
              } else if (state is CategoriesLoaded) {
                return CategoryList(
                  categories: state.categories,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                );
              } else {
                return Center(
                  child: Text(
                    'Error loading categories',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.red,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextsInHomeview(
      text: 'Categories',
      text2: 'See All',
      onTap: () {
       GoRouter.of(context).push(Routes.shopbycategories);

      },
    );
  }
}
