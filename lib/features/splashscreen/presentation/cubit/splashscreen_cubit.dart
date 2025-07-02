import 'package:bloc/bloc.dart';
import 'package:electro/features/authintication/domain/usecases/isLoggined_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  final IslogginedUsecase islogginedUsecase;

  SplashscreenCubit(this.islogginedUsecase) : super(SplashscreenInitial());

  void display() async {
    emit(SplashscreenDisplay());
    await Future.delayed(const Duration(seconds: 3));
    authinticateduser();
  }

void authinticateduser() async {
  final result = await islogginedUsecase.call();
  result.fold(
    (l) {
      emit(UnAuthinticated());
    },
    (r) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(UnAuthinticated());
      } else {
        emit(Authinticated());
      }
    },
  );
}

}
