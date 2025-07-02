import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/home/presentation/cubit/dropdowncubit/dropdown_cubit.dart';
import 'package:electro/features/home/presentation/cubit/dropdowncubit/filter_cubit.dart';
import 'package:electro/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:electro/features/home/presentation/widgets/search_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductsCubit>(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(
            context.read<ProductsCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => DropdownCubit(),
        ),
      ],
      child: const SearchViewBody(),
    );
  }
}