import 'package:electro/core/utils/app_strings.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/core/validations/validation.dart';
import 'package:electro/core/widgets/custom_textfield.dart';
import 'package:electro/features/authintication/presentation/cubit/forgetpassword/cubit/forgetpasswordreset_cubit.dart';
import 'package:flutter/material.dart';

class FormForgetpassword extends StatelessWidget {
  const FormForgetpassword({
    super.key,
    required this.cubit,
    required this.screenHeight,
  });

  final ForgetpasswordresetCubit cubit;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forgot Password',
            style: TextStyles.authtitle.copyWith(
              fontSize: screenHeight * 0.03,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.email,
            controller: cubit.emailController,
            validator: Validation.validateEmail,
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.06,
            child: ElevatedButton(
              onPressed: () {
                if (cubit.formkey.currentState!.validate()) {
                  cubit.forgetpassword(cubit.emailController.text);
                }
              },
              child: Text(
                AppStrings.continueText,
                style: TextStyles.authtitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}