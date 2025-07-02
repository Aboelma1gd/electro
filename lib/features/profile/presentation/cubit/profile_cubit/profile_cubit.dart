import 'package:bloc/bloc.dart';
import 'package:electro/features/checkout/domain/usecases/getaddress_usecase.dart';
import 'package:electro/features/profile/domain/entities/user_entity.dart';
import 'package:electro/features/profile/domain/usecases/profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase profileUsecase;
  final GetaddressUsecase getaddressUsecase;
  final ImagePicker imagePicker = ImagePicker();
  final SharedPreferences prefs;
  static const String KEY_PROFILE_IMAGE = 'profile_image_path';
  ProfileCubit(this.profileUsecase, this.prefs, this.getaddressUsecase) : super(ProfileInitial());

  Future<void> getUserData(String userId) async {
    emit(ProfileLoading());
    final result = await profileUsecase.getUserData(userId);
    result.fold(
      (failure) {
        print("Error in getUserData: $failure");
        emit(ProfileError(failure.message));
      },
      (profile) async {
        emit(ProfileLoaded(profile)); // أولًا تحميل المستخدم بدون عنوان
      },
    );
  }

  Future<void> logout() async {
    await profileUsecase.logout();
    
    emit(ProfileLogout());
    print("User logged out");
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await prefs.setString(KEY_PROFILE_IMAGE, pickedFile.path);
        emit(ImagePicked(pickedFile.path));
      } else {
        emit(const ImagePickedError("No image selected"));
      }
    } catch (e) {
      emit(ImagePickedError("Error picking image: $e"));
    }
  }
}

