part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity profile;
  const ProfileLoaded(this.profile);
}

class ProfileUnauthenticated extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}

class ProfileLogout extends ProfileState {}

class ImagePicked extends ProfileState {
  final String imagePath;
  const ImagePicked(this.imagePath);
}

class ImagePickedError extends ProfileState {
  final String message;
  const ImagePickedError(this.message);
}


