import 'package:bloc/bloc.dart';
import 'package:electro/features/profile/data/models/complaint_model.dart';
import 'package:electro/features/profile/domain/usecases/complaint_usecase.dart';
import 'package:flutter/widgets.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final ComplaintUsecase complaintUsecase;
  final TextEditingController complaint = TextEditingController();
  ComplaintCubit(this.complaintUsecase) : super(ComplaintInitial());

  Future<void> addcomplaint(ComplaintModel complaint) async {
    emit(ComplaintInitial());
    final result = await complaintUsecase.call(ComplaintModel(userEmail: complaint.userEmail, description: complaint.description,id: complaint.id));
    result.fold(
      (failure) => emit(ComplaintError(failure.message)), 
      (r) {
        this.complaint.clear();
        emit(ComplaintSendSuccess());
      }
    );
  }
}
