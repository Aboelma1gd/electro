import 'package:electro/config/extentions/extension.dart';
import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/profile/presentation/cubit/complaint_cubit/cubit/complaint_cubit.dart';
import 'package:electro/features/profile/presentation/widgets/complaint_iconbutton.dart';
import 'package:electro/features/profile/presentation/widgets/complaint_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintSection extends StatelessWidget {
  const ComplaintSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ComplaintCubit>(),
      child: BlocListener<ComplaintCubit, ComplaintState>(
        listener: (context, state) {
          if (state is ComplaintSendSuccess) {
            successmessage(context, 'Complaint sent successfully');
          } else if (state is ComplaintError) {
            errormessage(context, 'Failed to send complaint');
          }
        },
        child: BlocBuilder<ComplaintCubit, ComplaintState>(
          builder: (context, state) {
            return const Column(
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                     ComplaintTextFormField(),
                     ComplaintIconButton(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}