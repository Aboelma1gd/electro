import 'package:electro/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FilledConatiner extends StatelessWidget {
  const FilledConatiner({
    super.key,
    required this.screenWidth,  this.icon,
  });

  final double screenWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: screenWidth * 0.06,
      ),
    );
  }
}