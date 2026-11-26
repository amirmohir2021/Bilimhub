
import 'package:flutter/material.dart';

class ChildLinkCodePage extends StatelessWidget {
  const ChildLinkCodePage({super.key});

  static const Color primaryColor = Color(0xFF3468F5);

  void showServerMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Haqiqiy kod yaratish uchun server tizimi ulanishi kerak.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('Ota-onamni bog‘lash'),
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Bog‘lash kodi',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ota-onangiz ushbu kod yoki QR-kod orqali '
                'sizning hisobingizni topishi mumkin.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),

          // Bir martalik kod oynasi
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'SIZNING KODINGIZ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  '------',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Haqiqiy kod server ulangach yaratiladi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => showServerMessage(context),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Yangi kod yaratish'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // QR-kod oynasi
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'QR-KOD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE0E7F5),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_2_rounded,
                        size: 105,
                        color: primaryColor,
                      ),
                      Text(
                        'QR-kod hali yaratilmagan',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Ota-onangiz ushbu QR-kodni '
                      'o‘z telefonida skanerlaydi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Xavfsizlik haqida
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
                    'Bog‘lanish faqat ota-ona tasdiqlaganidan '
                        'keyin amalga oshadi. Kod bir martalik '
                        'va cheklangan muddatli bo‘ladi.',
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
