import 'package:flutter/material.dart';
import 'package:electro/constants/images.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:electro/core/utils/app_colors.dart';

class SplashscreenViewBody extends StatefulWidget {
  const SplashscreenViewBody({super.key});

  @override
  State<SplashscreenViewBody> createState() => _SplashscreenViewBodyState();
}

class _SplashscreenViewBodyState extends State<SplashscreenViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Image.asset(
                    Assets.imagesElectro,
                    width: screenWidth,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                    cacheWidth: (screenWidth * 2).toInt(),
                    cacheHeight:
                        (MediaQuery.of(context).size.height * 2).toInt(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
