import 'package:bloc/bloc.dart';
import 'package:electro/features/checkout/data/models/address_model.dart';
import 'package:electro/features/checkout/domain/entities/address_entity.dart';
import 'package:electro/features/checkout/domain/usecases/checkout_usecase.dart';
import 'package:electro/features/checkout/domain/usecases/getaddress_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutUsecase checkoutUsecase;
  final GetaddressUsecase getaddressUsecase;
  CheckoutCubit(this.checkoutUsecase, this.getaddressUsecase)
      : super(CheckoutInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  bool hasAddress = false;
  AddressEntity? currentAddress;

  Future<void> checkUserAddress(String userId) async {
    emit(CheckoutLoading());
    final result =
        await getaddressUsecase.addressRepository.getUserAddress(userId);
    result.fold(
      (failure) {
        hasAddress = false;
        currentAddress = null;
        emit(AddadressError(failure.message));
      },
      (address) {
        hasAddress = true;
        currentAddress = address;
        emit(AddadressLoaded(address));
      },
    );
  }

  Future<void> submitForm(String userId) async {
    if (formKey.currentState!.validate()) {
      emit(CheckoutLoading());
      final address = AddressModel(
        name: nameController.text,
        mobileNumber: mobileNumberController.text,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        zipCode: zipController.text,
      );
      final result = await checkoutUsecase(address, userId);
      result.fold(
        (failure) {
          hasAddress = false;
          currentAddress = null;
          emit(AddadressError(failure.message));
        },
        (address) {
          hasAddress = true;
          currentAddress = address;
          emit(AddadressLoaded(address));
        },
      );
    }
  }

  String? getFormattedAddress() {
    if (currentAddress != null) {
      return '${currentAddress!.address}, ${currentAddress!.city}\n${currentAddress!.state}, ${currentAddress!.zipCode}';
    }
    return null;
  }

  void clearControllers() {
    nameController.clear();
    mobileNumberController.clear();
    addressController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    return super.close();
  }
}
