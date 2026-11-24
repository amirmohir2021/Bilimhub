
import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const SimplePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 75,
              color: const Color(0xFF3468F5),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF20345C),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF8792A5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
