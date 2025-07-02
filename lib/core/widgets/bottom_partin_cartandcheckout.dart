import 'package:electro/config/routing/routes.dart';
import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomPartIncartandcheckout extends StatelessWidget {
  const BottomPartIncartandcheckout({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
   
  });

  final double screenWidth;
  final double screenHeight;


  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: screenWidth * 0.05,
      right: screenWidth * 0.05,
      bottom: screenHeight * 0.03,
      child: Container(
        width:  screenWidth * 0.9,
        height:  screenHeight * 0.3,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
           // RowTotals(text1: 'SubTotal', text2: '29\$'),
            SizedBox(height: screenHeight * 0.01),
            //RowTotals(text1: 'Shipping', text2: 'Free'),
            SizedBox(height: screenHeight * 0.01),
            //RowTotals(text1: cartEntity.totalPrice.toString(), text2: '29\$'),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).go(Routes.addreviews);
                },
                child: const Text('Checkout', style: TextStyles.textinhome),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
