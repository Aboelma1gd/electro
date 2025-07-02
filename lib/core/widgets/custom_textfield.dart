import 'package:electro/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final bool? obscureText; // Make it non-nullable
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? readOnly;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    required this.title,
    this.obscureText,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.readOnly, // Default value here
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText ??
          false, // No error will occur as the value is guaranteed
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: title,
        hintStyle: TextStyles.authtitle.copyWith(
          fontSize: 16,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
