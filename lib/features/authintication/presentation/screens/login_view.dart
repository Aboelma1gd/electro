import 'package:electro/features/authintication/presentation/cubit/logincubit/cubit/login_cubit.dart';
import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/authintication/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: const LoginViewBody(),
    );
  }
}
