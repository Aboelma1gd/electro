part of 'complaint_cubit.dart';

sealed class ComplaintState {
  const ComplaintState();
}

final class ComplaintInitial extends ComplaintState {}

final class ComplaintSendSuccess extends ComplaintState {}

final class ComplaintError extends ComplaintState {
  final String message;
  const ComplaintError(this.message);
}
