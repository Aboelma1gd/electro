import 'package:cached_network_image/cached_network_image.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/core/utils/routes.dart';

class ShopByCategories extends StatelessWidget {
  const ShopByCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenwidth * 0.05,
          vertical: screenhight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            SizedBox(height: screenhight * 0.02),
            Text(
              'Shop By Categories',
              style: TextStyles.textinhome.copyWith(
                fontSize: screenwidth * 0.06,
              ),
            ),
            SizedBox(height: screenhight * 0.02),
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: screenwidth * 0.008,
                      ),
                    );
                  }
                  if (state is CategoriesError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is CategoriesLoaded) {
                    return ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(
                            '${Routes.products}/${state.categories[index].id}',
                          );
                        },
                        child: Container(
                          width: screenwidth,
                          height: screenhight * 0.1,
                          margin: EdgeInsets.only(
                            bottom: screenhight * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x1AFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenwidth * 0.05,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: screenwidth * 0.13,
                                height: screenwidth * 0.13,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      state.categories[index].image.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenwidth * 0.05),
                              Text(
                                state.categories[index].title.toString(),
                                style: TextStyles.textinhome.copyWith(
                                  fontSize: screenwidth * 0.04,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
