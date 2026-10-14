import 'package:ecommerce_app_huma_volve/core/services/get_it.dart';
import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  getItsetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
