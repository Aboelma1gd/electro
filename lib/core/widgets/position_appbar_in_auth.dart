import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/widgets/applogo.dart';
import 'package:flutter/material.dart';

class PositionAppBarInAuth extends StatelessWidget {
  const PositionAppBarInAuth({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.25,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AppLogo()],
        ),
      ),
    );
  }
}