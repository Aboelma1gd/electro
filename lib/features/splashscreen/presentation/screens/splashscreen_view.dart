import 'package:electro/core/services/firebase_auth_services.dart';
import 'package:electro/features/authintication/data/repositories/auth_repositry_impl.dart';
import 'package:electro/features/authintication/domain/usecases/isLoggined_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/config/routing/routes.dart';
import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/features/splashscreen/presentation/cubit/splashscreen_cubit.dart';
import 'package:electro/features/splashscreen/presentation/widgets/splashscreen_view_body.dart';
import 'package:go_router/go_router.dart';

class SplashscreenView extends StatelessWidget {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashscreenCubit(
        IslogginedUsecase(
          AuthRepositryImpl(firebaseAuthServices: FirebaseAuthServices()),
        ),
      )..display(),
      child: BlocListener<SplashscreenCubit, SplashscreenState>(
        listener: (context, state) {
          if (state is Authinticated) {
            context.go(Routes.home);
          } else if (state is UnAuthinticated) {
            context.go(Routes.onboarding);
          }
        },
        child: const Scaffold(
          backgroundColor: AppColors.primary,
          body: SplashscreenViewBody(),
        ),
      ),
    );
  }
}
