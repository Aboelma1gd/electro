import 'package:electro/config/routing/routes.dart';
import 'package:electro/core/utils/text_styles.dart';
import 'package:electro/core/widgets/custom_button.dart';
import 'package:electro/features/onboarding/presentation/widgets/data.dart';
import 'package:electro/features/onboarding/presentation/widgets/listview_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// OnboardingViewBody
class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  _OnboardingViewBodyState createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController1.hasClients &&
          _scrollController2.hasClients &&
          _scrollController3.hasClients) {
        double minScrollExtent1 = _scrollController1.position.minScrollExtent;
        double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
        double minScrollExtent2 = _scrollController2.position.minScrollExtent;
        double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;
        double minScrollExtent3 = _scrollController3.position.minScrollExtent;
        double maxScrollExtent3 = _scrollController3.position.maxScrollExtent;

        animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
            _scrollController1);
        animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 15,
            _scrollController2);
        animateToMaxMin(maxScrollExtent3, minScrollExtent3, maxScrollExtent3, 20,
            _scrollController3);
      }
    });
  }

  void animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Welcome to Electro',
                  style: TextStyles.authtitle.copyWith(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontFamily: 'Italianno',
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                MoviesListView(
                  scrollController: _scrollController1,
                  images: movies1,
                  height: screenHeight * 0.15,
                  imageWidth: screenWidth * 0.2,
                ),
                MoviesListView(
                  scrollController: _scrollController2,
                  images: movies2,
                  height: screenHeight * 0.15,
                  imageWidth: screenWidth * 0.2,
                ),
                MoviesListView(
                  scrollController: _scrollController3,
                  images: movies3,
                  height: screenHeight * 0.15,
                  imageWidth: screenWidth * 0.2,
                ),
              ],
            ),
            CustomButton(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              buttontext: 'Get Started',
              onPressed: () => context.push(Routes.register),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }
}
