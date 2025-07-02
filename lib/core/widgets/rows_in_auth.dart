import 'package:electro/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class RowsInAuth extends StatelessWidget {
  final String text1, text2;
  final void Function()? onPressed;

  const RowsInAuth({
    super.key,
    required this.text1,
    required this.text2,
     this.onPressed, // اجعلها إلزامية
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text1,
          style: TextStyles.authtitle.copyWith(fontSize: 12),
        ),
        TextButton(
          onPressed: onPressed, // عند الضغط
          child: Text(
            text2,
            style: TextStyles.authtitle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
