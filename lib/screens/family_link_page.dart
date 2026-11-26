import 'package:flutter/material.dart';

class FamilyLinkPage extends StatelessWidget {
  const FamilyLinkPage({super.key});

  static const Color primaryColor = Color(0xFF3468F5);

  void showInfo(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text(
          'Bu imkoniyat server tizimi ulangandan keyin ishlaydi. '
              'Hozircha interfeys tayyorlanmoqda.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tushunarli'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('Oila bilan bog‘lanish'),
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.family_restroom_rounded,
            size: 65,
            color: primaryColor,
          ),
          const SizedBox(height: 12),
          const Text(
            'BilimHub oilasi',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ota-ona va farzand profillarini xavfsiz bog‘lang.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 28),

          _FamilyCard(
            icon: Icons.child_care_rounded,
            title: 'Men farzandman',
            subtitle: 'Ota-onam bilan hisobimni bog‘lamoqchiman',
            buttonText: 'Bog‘lash kodini yaratish',
            onPressed: () {
              showInfo(context, 'Farzand hisobini bog‘lash');
            },
          ),

          const SizedBox(height: 16),

          _FamilyCard(
            icon: Icons.supervisor_account_rounded,
            title: 'Men ota-onaman',
            subtitle: 'Farzandimning hisobini bog‘lamoqchiman',
            buttonText: 'Kod orqali bog‘lash',
            onPressed: () {
              showInfo(context, 'Farzand kodini kiritish');
            },
            secondaryButtonText: 'QR-kodni skanerlash',
            onSecondaryPressed: () {
              showInfo(context, 'QR-kodni skanerlash');
            },
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.security_rounded,
                  color: primaryColor,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bog‘lanish ota-ona tasdiqlaganidan keyin '
                        'amalga oshadi. Farzand o‘z ma’lumotlari '
                        'qanday ko‘rinishini bilib turadi.',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const _FamilyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 35, color: const Color(0xFF3468F5)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ),
          if (secondaryButtonText != null) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onSecondaryPressed,
                icon: const Icon(Icons.qr_code_scanner_rounded),
                label: Text(secondaryButtonText!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}