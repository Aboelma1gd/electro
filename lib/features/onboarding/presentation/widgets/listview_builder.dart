import 'package:flutter/material.dart';

class MoviesListView extends StatelessWidget {
  final ScrollController? scrollController;
  final List? images;
  final double height;
  final double imageWidth;

  const MoviesListView({
    super.key,
    this.scrollController,
    this.images,
    required this.height,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: images!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(screenWidth * 0.025), // 2.5% من عرض الشاشة
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.06), // 6% من عرض الشاشة
              child: Image.asset(
                '${images![index]}',
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}