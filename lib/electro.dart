import 'package:electro/config/routing/routing_app.dart';
import 'package:electro/config/themes/themeapp.dart';
import 'package:flutter/material.dart';

class Electro extends StatelessWidget {
  const Electro({super.key}); // استخدم `const` لتحسين الأداء

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Electro',
      theme: themeApp, // تأكد أن `themeApp` معرف في `themeapp.dart`
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router, // استخدم `GoRouter`
    );
  }
}
