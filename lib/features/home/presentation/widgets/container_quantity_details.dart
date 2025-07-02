// ignore_for_file: library_private_types_in_public_api

import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerQuantityInDetails extends StatefulWidget {
  final int quantity;
  final Function(int) onQuantityChanged;

  const ContainerQuantityInDetails({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  _ContainerQuantityInDetailsState createState() => _ContainerQuantityInDetailsState();
}

class _ContainerQuantityInDetailsState extends State<ContainerQuantityInDetails> {
  late int tempQuantity;

  @override
  void initState() {
    super.initState();
    tempQuantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
   context.watch<CartCubit>();
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Quantity', style: TextStyles.textinhome),
          ),
          Row(
            children: [
              _QuantityButton(
                icon: Icons.remove,
                onTap: () {
                  if (tempQuantity > 1) {
                    setState(() {
                      tempQuantity--;
                    });
                    widget.onQuantityChanged(tempQuantity);
                  }
                },
              ),
              Text('$tempQuantity'),
              _QuantityButton(
                icon: Icons.add,
                onTap: () {
                  setState(() {
                    tempQuantity++;
                  });
                  widget.onQuantityChanged(tempQuantity);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onTap,
    );
  }
}
