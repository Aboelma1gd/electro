import 'package:bloc/bloc.dart';

class DropdownCubit extends Cubit<String?> {
  DropdownCubit() : super(null);

  void selectItem(String? value) {
    print("Selected value: $value");
    emit(value);
  }
}