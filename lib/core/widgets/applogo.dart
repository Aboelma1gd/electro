import 'package:electro/constants/images.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            Assets.imagesLogo,
            height: screenHeight * 0.15,
            width: screenWidth * 0.45,
          ),
        ),
      ],
    );
  }
}
