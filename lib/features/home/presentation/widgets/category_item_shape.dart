import 'package:flutter/material.dart';

class CategoryShapeItem extends StatelessWidget {
  const CategoryShapeItem({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.13,
              height: screenWidth * 0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              width: screenWidth * 0.13,
              height: screenWidth * 0.02,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
