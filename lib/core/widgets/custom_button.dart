import 'package:electro/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight, required this.buttontext, this.onPressed,
  });

  final double screenWidth;
  final double screenHeight;
  final String buttontext;
  final  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // 5% من عرض الشاشة
        vertical: screenHeight * 0.02, // 2% من ارتفاع الشاشة
      ),
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: screenWidth * 0.85, // 85% من عرض الشاشة
          height: screenHeight * 0.07, // 7% من ارتفاع الشاشة
          child: Text(
            buttontext,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05, // 5% من عرض الشاشة
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}