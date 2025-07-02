import 'package:electro/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class TextsInHomeview extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onTap;
  final String? text2;
  const TextsInHomeview({
    super.key, 
    required this.text, 
    this.color, 
    this.onTap, this.text2
  });

  @override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text, 
        style: TextStyles.textinhome.copyWith(color: color),
      ),
      Visibility(
        visible: text2 != null && text2!.isNotEmpty, // شرط الظهور
        child: GestureDetector(
          onTap: onTap,
          child: Text(text2 ?? '', style: TextStyles.seealltext),
        ),
      ),
    ],
  );
}

}