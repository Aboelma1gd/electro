import 'dart:io';

import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is ProfileLoaded,
      builder: (context, state) {
        final profile = state is ProfileLoaded ? state.profile : null;
        String? imagePath =
            context.read<ProfileCubit>().prefs.getString('profile_image_path');

        return Card(
          color: AppColors.secondBackground,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _handleImageSelection(context),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: imagePath != null
                            ? FileImage(File(imagePath))
                            : const AssetImage(
                                    'assets/images/default_profile_image.png')
                                as ImageProvider,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${profile?.firstName ?? 'First'} ${profile?.lastName ?? 'Last'}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (profile?.email != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          profile!.email,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleImageSelection(BuildContext context) async {
    final ProfileCubit cubit = context.read<ProfileCubit>();

    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext bottomSheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                GoRouter.of(context).pop();
                cubit.pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                GoRouter.of(context).pop();
                cubit.pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
