import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/features/profile/presentation/cubit/complaint_cubit/cubit/complaint_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintTextFormField extends StatelessWidget {
  const ComplaintTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ComplaintCubit>().complaint,
      maxLines: 5,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.transparent,
        filled: true,
        border: _borderStyle(),
        focusedBorder: _borderStyle(),
        enabledBorder: _borderStyle(),
        labelText: 'For Complaints',
      ),
    );
  }
   OutlineInputBorder _borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
    );
  }
}
