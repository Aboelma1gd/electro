import 'package:electro/config/extentions/extension.dart';
import 'package:electro/config/routing/routes.dart';
import 'package:electro/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:electro/features/profile/presentation/widgets/complaint_widget.dart';
import 'package:electro/features/profile/presentation/widgets/profile_header.dart';
import 'package:electro/features/profile/presentation/widgets/profile_info_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            errormessage(context, state.message);
          }
          if (state is ProfileLogout) {
            GoRouter.of(context).go(Routes.login);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: screenSize.height * 0.04),
                const ProfileHeader(),
                SizedBox(height: screenSize.height * 0.04),
                const ProfileInfoList(),
                const ComplaintSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
