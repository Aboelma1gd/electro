import 'package:electro/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dropdowncubit/dropdown_cubit.dart';
import '../cubit/dropdowncubit/filter_cubit.dart';

class DropDownForChoiceInSearch extends StatelessWidget {
  final double screenWidth;
  final String text1;
  final List<String> items;
  final String filterType;

  const DropDownForChoiceInSearch({
    super.key,
    required this.screenWidth,
    required this.text1,
    required this.items,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DropdownCubit(),
      child: BlocBuilder<DropdownCubit, String?>(
        builder: (context, selectedValue) {
          return Container(
            width: screenWidth * 0.4, // Set width relative to screen
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03), // Add internal padding
            decoration: BoxDecoration(
              color: Colors.transparent, // White background
              borderRadius: BorderRadius.circular(20), // Rounded corners
              border: Border.all(
                color: AppColors.primary, // Set border color
                width: 1.5, // Border thickness
              ),
            ),
            child: DropdownButtonHideUnderline(
              // Hide default underline
              child: DropdownButton<String>(
                isExpanded: true, // Make dropdown expand inside container
                hint: Text(text1,
                    style: const TextStyle(
                        color: Colors.grey)), // Default text color
                value: selectedValue,
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        style: const TextStyle(
                            fontSize: 16)), // Increase font size
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<DropdownCubit>().selectItem(value);
                    if (filterType == "price") {
                      context.read<FilterCubit>().setFilter(price: value);
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
