import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/widgets/product_item.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:electro/features/home/presentation/widgets/product_grid_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.categoryId});
 final String categoryId;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const Expanded(
                  child: Text(
                    'Category Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 40), // Balance the title
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Products',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                ' (${state.products.length})',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.75,
                                ),
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final ProductEntity product =
                                  state.products[index];
                              return GestureDetector(
                                onTap: () {
                                  GoRouter.of(
                                    context,
                                  ).push('/details', extra: product);
                                },
                                child: ProductItem(productEntity: product),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is ProductsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const ProductGridSkeleton();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
