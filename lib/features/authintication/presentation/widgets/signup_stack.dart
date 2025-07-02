import 'package:electro/core/widgets/position_appbar_in_auth.dart';
import 'package:electro/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:electro/features/authintication/presentation/widgets/form_signup.dart';
import 'package:flutter/material.dart';

class SignupStack extends StatelessWidget {
  const SignupStack({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.cubit,
  });

  final double screenHeight;
  final double screenWidth;
  final AuthinticationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         PositionAppBarInAuth(screenHeight: screenHeight),
        Positioned(
          top: screenHeight * 0.19,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: screenHeight * 0.7,
              maxHeight: screenHeight * 0.8,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: FormSignup(cubit: cubit, screenHeight: screenHeight),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
