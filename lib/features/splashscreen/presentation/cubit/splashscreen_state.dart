part of 'splashscreen_cubit.dart';

abstract class SplashscreenState extends Equatable {
  const SplashscreenState();

  @override
  List<Object> get props => [];
}

class SplashscreenInitial extends SplashscreenState {}

class SplashscreenDisplay extends SplashscreenState {}

class SplashscreenDisplayDone extends SplashscreenState {}

class Authinticated extends SplashscreenState {}

class UnAuthinticated extends SplashscreenState {}