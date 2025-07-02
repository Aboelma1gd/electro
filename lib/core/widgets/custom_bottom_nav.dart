// ignore_for_file: library_private_types_in_public_api
// import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
// import 'package:electro/features/cart/presentation/screens/cart_view.dart';
// import 'package:electro/features/home/presentation/screens/home_view.dart';
// import 'package:electro/features/notifications/presentation/cubit/notifications_cubit.dart';
// import 'package:electro/features/notifications/presentation/screens/notification_view.dart';
// import 'package:electro/features/profile/presentation/screens/profile_view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/features/gemini_chat/presentation/widgets/gemini_chat_widget.dart';
// import 'package:electro/config/routing/routes.dart';
// import 'package:electro/injection.dart' as di;

class Salmon extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const Salmon({super.key, required this.navigationShell});

  @override
  _SalmonState createState() => _SalmonState();
}

class _SalmonState extends State<Salmon> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.navigationShell.currentIndex;
  }

  void _showChatDialog(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: screenHeight * .9,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const GeminiChatWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        } else {
          setState(() {
            _currentIndex = 0;
          });
          widget.navigationShell.goBranch(0);
          return false;
        }
      },
      child: Scaffold(
        key: widget.key,
        body: widget.navigationShell,
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 2) {
              // Chat icon index
              _showChatDialog(context);
            } else if (index > 2) {
              // Adjust index for cart and profile since chat is inserted
              setState(() {
                _currentIndex = index;
              });
              widget.navigationShell.goBranch(index - 1);
            } else {
              setState(() {
                _currentIndex = index;
              });
              widget.navigationShell.goBranch(index);
            }
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text(""),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.notifications),
              title: const Text(""),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.chat_bubble_outline),
              title: const Text(""),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_cart),
              title: const Text(""),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
