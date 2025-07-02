import 'package:electro/config/routing/routes.dart';
// import 'package:electro/constants/images.dart';
// import 'package:electro/core/widgets/empty_container.dart';
import 'package:electro/features/authintication/presentation/cubit/forgetpassword/cubit/forgetpasswordreset_cubit.dart';
import 'package:electro/features/authintication/presentation/widgets/forgetpassword_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:electro/config/extentions/extension.dart';
// ... rest of imports

class ForgetpasswordViewBody extends StatelessWidget {
  const ForgetpasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<ForgetpasswordresetCubit, ForgetpasswordresetState>(
      listener: (context, state) {
        if (state is ForgetpasswordresetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          context.go(Routes.login);
        } else if (state is ForgetpasswordresetError) {
          errormessage(context, state.message);
        }
      },
      builder: (context, state) {
        var cubit = context.read<ForgetpasswordresetCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is ForgetpasswordresetLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: FrgetpasswordStack(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                cubit: cubit),
          ),
        );
      },
    );
  }
}
