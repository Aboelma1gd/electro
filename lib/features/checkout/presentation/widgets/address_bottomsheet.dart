import 'package:electro/config/extentions/extension.dart';
// import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/checkout/domain/entities/address_entity.dart';

class AddressBottomSheet extends StatefulWidget {
  final AddressEntity? initialAddress;

  const AddressBottomSheet({super.key, this.initialAddress});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  late final CheckoutCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CheckoutCubit>();
    if (widget.initialAddress != null) {
      _cubit.nameController.text = widget.initialAddress!.name;
      _cubit.mobileNumberController.text = widget.initialAddress!.mobileNumber;
      _cubit.addressController.text = widget.initialAddress!.address;
      _cubit.cityController.text = widget.initialAddress!.city;
      _cubit.stateController.text = widget.initialAddress!.state;
      _cubit.zipController.text = widget.initialAddress!.zipCode;
    } else {
      // Clear controllers if no initial address is provided (for adding new address)
      _cubit.nameController.clear();
      _cubit.mobileNumberController.clear();
      _cubit.addressController.clear();
      _cubit.cityController.clear();
      _cubit.stateController.clear();
      _cubit.zipController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration: const BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is AddadressLoaded) {
            Navigator.pop(context, {
              'name': state.address.name,
              'mobileNumber': state.address.mobileNumber,
              'address': state.address.address,
              'city': state.address.city,
              'state': state.address.state,
              'zip': state.address.zipCode,
            });
          } else if (state is AddadressError) {
            errormessage(context, state.message);
          }
        },
        child: Form(
          key: _cubit.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.initialAddress != null
                    ? 'Update Shipping Address'
                    : 'Add Shipping Address',
                style: TextStyles.textinhome,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _cubit.nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _cubit.mobileNumberController,
                label: 'Mobile Number',
                hint: 'Enter your mobile number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _cubit.addressController,
                label: 'Street Address',
                hint: 'Enter your street address',
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _cubit.cityController,
                label: 'City',
                hint: 'Enter your city',
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _cubit.stateController,
                      label: 'State',
                      hint: 'Enter state',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField(
                      controller: _cubit.zipController,
                      label: 'ZIP Code',
                      hint: 'Enter ZIP code',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    String userId = FirebaseAuth.instance.currentUser!.uid;
                    _cubit.submitForm(userId);
                  },
                  child: _cubit.state is CheckoutLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.initialAddress != null
                              ? 'Update Address'
                              : 'Save Address',
                          style: const TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
