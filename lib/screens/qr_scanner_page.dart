import 'package:flutter/material.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  static const Color primaryColor = Color(0xFF3468F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('QR-kodni skanerlash'),
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Text(
              'Farzandingiz QR-kodini skanerlang',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Farzandingiz o‘z profilida yaratgan QR-kodni '
                  'kamera orqali skanerlang.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 35),

            Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 110,
                    color: primaryColor,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Kamera oynasi',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'QR-kod skanerlangandan keyin '
                  'farzandingizga bog‘lanish so‘rovi yuboriladi.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Kamera server va skaner tizimi ulangandan '
                            'keyin ishlaydi.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt_rounded),
                label: const Text('Kamerani ishga tushirish'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}