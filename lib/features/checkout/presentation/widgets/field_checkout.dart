import 'package:flutter/material.dart';
import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/utils/text_styles.dart';

class FieldCheckout extends StatelessWidget {
  const FieldCheckout({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        width: double.infinity,
        height: screenHeight * 0.13,
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyles.textinhome.copyWith(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(text2, style: TextStyles.textinhome.copyWith(fontSize: 18)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}