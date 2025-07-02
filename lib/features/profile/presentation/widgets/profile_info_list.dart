import 'package:electro/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:electro/features/profile/presentation/widgets/profile_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileInfoList extends StatelessWidget {
  const ProfileInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is ProfileLoaded,
      builder: (context, state) {
        final profile = (state is ProfileLoaded) ? state.profile : null;

        return Column(
          children: [
            ProfileInfoTile(
              icon: Icons.email,
              label: 'Email',
              value: profile?.email ?? 'Not set',
            ),
            ProfileInfoTile(
              icon: Icons.logout,
              label: 'Logout',
              value: 'Tap to logout',
              onTap: () => _confirmLogout(context),
              color: Colors.white,
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => GoRouter.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => GoRouter.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      context.read<ProfileCubit>().logout();
    }
  }
}
