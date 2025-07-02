import 'package:electro/config/extentions/extension.dart';
import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/features/profile/data/models/complaint_model.dart';
import 'package:electro/features/profile/presentation/cubit/complaint_cubit/cubit/complaint_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ComplaintIconButton extends StatelessWidget {
  const ComplaintIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: IconButton(
        icon: const Icon(Icons.send),
        color: AppColors.primary,
        onPressed: () {
          final complaintText =context.read<ComplaintCubit>().complaint.text.trim();
          if (complaintText.isEmpty) {
            errormessage(context, 'Please enter your complaint');
          } else {
            context.read<ComplaintCubit>().addcomplaint(
                  ComplaintModel(
                    description: complaintText,
                    id: const Uuid().v4(),
                    userEmail: FirebaseAuth.instance.currentUser!.email!,
                  ),
                );
          }
        },
      ),
    );
  }
}