import 'package:electro/features/home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart'; // Remove GoRouter import if no longer needed here

class HomeView extends StatelessWidget {
  // Removed navigationShell parameter

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeViewBody(); // Removed passing navigationShell
  }
}
