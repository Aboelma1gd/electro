import 'dart:io';
// import 'package:electro/config/routing/routes.dart';
import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/widgets/filled_container.dart';
import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:electro/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomAppbarinhome extends StatelessWidget {
  const CustomAppbarinhome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Image Section
          BlocProvider(
            create: (context) => sl<ProfileCubit>(),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                String? imagePath;
                if (state is ImagePicked) {
                  imagePath = state.imagePath;
                } else {
                  imagePath = context.read<ProfileCubit>().prefs.getString(
                        ProfileCubit.KEY_PROFILE_IMAGE,
                      );
                }

                return GestureDetector(
                  onTap: () {
                    StatefulNavigationShell.of(context).goBranch(3);
                  },
                  child: CircleAvatar(
                    radius: screenHeight * 0.03,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath))
                        : const AssetImage(
                            'assets/images/default_profile_image.png',
                          ) as ImageProvider,
                    backgroundColor: AppColors.secondBackground,
                  ),
                );
              },
            ),
          ),

          // Men Text Container
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.01,
            ),
            child: const Text(
              'electro',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                fontFamily: 'Italianno',
              ),
            ),
          ),

          // Cart Icon
          GestureDetector(
            onTap: () {
              StatefulNavigationShell.of(context).goBranch(2);
            },
            child: Stack(
              children: [
                FilledConatiner(
                  screenWidth: screenWidth,
                  icon: Icons.shopping_bag_outlined,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      int itemCount = 0;

                      if (state is CartLoaded) {
                        itemCount = state.cartItems.length;
                      } else {
                        itemCount = sl<CartCubit>().cartItems.length;
                      }

                      return itemCount > 0
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                itemCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
