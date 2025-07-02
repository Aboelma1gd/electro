import 'package:electro/features/authintication/presentation/cubit/forgetpassword/cubit/forgetpasswordreset_cubit.dart';
import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/authintication/presentation/widgets/forgetpassword_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetpasswordView extends StatelessWidget {
  const ForgetpasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgetpasswordresetCubit>(),
      child: const ForgetpasswordViewBody(),
    );
  }
}
