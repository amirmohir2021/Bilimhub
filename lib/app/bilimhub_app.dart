
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../screens/main_screen.dart';

class BilimHubApp extends StatelessWidget {
  const BilimHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BilimHub',
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
