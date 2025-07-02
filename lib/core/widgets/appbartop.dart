import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Appbartop extends StatelessWidget {
  const Appbartop({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        const Customappbar(),
        SizedBox(width: screenWidth * 0.05),
        Text('Checkout', style: TextStyles.authtitle.copyWith(fontSize: screenWidth * 0.05)),
      ],
    );
  }
}