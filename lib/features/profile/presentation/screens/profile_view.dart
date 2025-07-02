import 'package:electro/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:electro/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:electro/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key,});
  //final String userId ;
  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
  
    return BlocProvider(
      create: (context) =>sl<ProfileCubit>()..getUserData(userid),
      child: const ProfileViewBody(),
    );
  }
}
