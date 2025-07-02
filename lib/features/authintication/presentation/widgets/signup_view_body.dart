import 'package:electro/features/authintication/presentation/widgets/signup_stack.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:electro/config/extentions/extension.dart';
import 'package:electro/config/routing/routes.dart';
import 'package:electro/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return BlocConsumer<AuthinticationCubit, AuthinticationState>(
      listener: (context, state) {
        if (state is AuthinticationSuccess) {
        context.push(Routes.home);
        } else if (state is AuthinticationFailure) {
          errormessage(context, state.message);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthinticationCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is AuthinticationLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SignupStack(screenHeight: screenHeight, screenWidth: screenWidth, cubit: cubit),
          ),
        );
      },
    );
  }
}

