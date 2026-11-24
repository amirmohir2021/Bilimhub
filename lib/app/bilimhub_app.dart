
import 'package:flutter/material.dart';
import '../screens/main_screen.dart';

class BilimHubApp extends StatelessWidget {
  const BilimHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BilimHub',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3468F5),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}
