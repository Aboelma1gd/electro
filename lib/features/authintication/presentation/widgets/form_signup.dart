import 'package:electro/config/routing/routes.dart';
// import 'package:electro/core/services/firebase_auth_services.dart';
import 'package:electro/core/utils/app_strings.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/core/validations/validation.dart';
import 'package:electro/core/widgets/custom_textfield.dart';
import 'package:electro/core/widgets/rows_in_auth.dart';
import 'package:electro/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:electro/features/authintication/presentation/widgets/signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FormSignup extends StatelessWidget {
  const FormSignup({
    super.key,
    required this.cubit,
    required this.screenHeight,
  });

  final AuthinticationCubit cubit;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.signupname,
            style: TextStyles.authtitle.copyWith(
              fontSize: screenHeight * 0.03,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.firstname,
            controller: cubit.firstnameController,
            validator: Validation.validateName,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.lastname,
            controller: cubit.lastnameController,
            validator: Validation.validateName,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.email,
            controller: cubit.emailController,
            validator: Validation.validateEmail,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            title: AppStrings.password,
            obscureText: context.watch<AuthinticationCubit>().isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            validator: Validation.validatePassword,
            controller: cubit.passwordController,
            suffixIcon: IconButton(
              icon: Icon(
                context.watch<AuthinticationCubit>().isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                cubit.togglePasswordVisibility();
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SignupButton(cubit: cubit),
          SizedBox(height: screenHeight * 0.03),
          RowsInAuth(
            text1: 'Already have an account?',
            text2: AppStrings.signinname,
            onPressed: () {
              context.push(Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
