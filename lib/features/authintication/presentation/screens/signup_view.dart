import 'package:electro/features/authintication/presentation/widgets/signup_view_body.dart';
import 'package:electro/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthinticationCubit>(),
      child: const SignupViewBody(),
    );
  }
}
