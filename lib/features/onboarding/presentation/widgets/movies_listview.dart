import 'package:electro/features/onboarding/presentation/widgets/data.dart';
import 'package:electro/features/onboarding/presentation/widgets/listview_builder.dart';
import 'package:flutter/material.dart';

class MoviewsListview extends StatelessWidget {
  const MoviewsListview({
    super.key,
    required ScrollController scrollController1,
    required this.screenHeight,
    required this.screenWidth,
  }) : _scrollController1 = scrollController1;

  final ScrollController _scrollController1;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return MoviesListView(
      scrollController: _scrollController1,
      images: movies1,
      height: screenHeight * 0.15, // 15% من ارتفاع الشاشة
      imageWidth: screenWidth * 0.2, // 20% من عرض الشاشة
    );
  }
}