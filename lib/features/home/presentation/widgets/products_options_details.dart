import 'package:electro/core/utils/app_colors.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductOptionsDisplay extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final Function(String) onOptionSelected;

  const ProductOptionsDisplay({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Select a $title', style: TextStyles.textinhome),
                      const SizedBox(height: 16),
                      if (options.isEmpty)
                        Text('No $title available',
                            style: TextStyles.textinhome.copyWith(color: Colors.grey))
                      else
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: options.map((option) {
                            return InkWell(
                              onTap: () {
                                onOptionSelected(option);
                               GoRouter.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.primary, width: 1),
                                  color: selectedOption == option ? AppColors.primary.withOpacity(0.2) : Colors.white,
                                ),
                                child: Text(
                                  option,
                                  style: TextStyles.textinhome.copyWith(fontSize: 14, color: AppColors.primary),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        child: const Text('Close', style: TextStyles.textinhome),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: ContainerSelectedOption(title: title, text1: selectedOption ?? title),
        ),
      ],
    );
  }
}

class ContainerSelectedOption extends StatelessWidget {
  final String title;
  final String text1;
  const ContainerSelectedOption({super.key, required this.title, required this.text1});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, style: TextStyles.textinhome),
          Row(
            children: [
              if (title == 'Colors')
                Container(
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                )
              else
                const Text('S', style: TextStyles.textinhome),
              const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
            ],
          )
        ],
      ),
    );
  }
}