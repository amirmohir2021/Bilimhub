import 'package:flutter/material.dart';

class FamilyLinkConfirmationPage extends StatelessWidget {
  const FamilyLinkConfirmationPage({super.key});

  static const Color primaryColor = Color(0xFF3468F5);

  void showServerMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'So‘rovni tasdiqlash uchun server tizimi ulanishi kerak.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('Bog‘lanishni tasdiqlash'),
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 15),

          const Icon(
            Icons.family_restroom_rounded,
            size: 75,
            color: primaryColor,
          ),

          const SizedBox(height: 16),

          const Text(
            'Farzandingiz bilan bog‘lanish',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Bog‘lanish so‘rovini ko‘rib chiqing va '
                'qaroringizni tasdiqlang.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 28),

          // Farzand profili
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Color(0xFFEAF0FF),
                  child: Icon(
                    Icons.child_care_rounded,
                    size: 42,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'Farzand profili',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Profil ma’lumotlari serverdan olinadi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Bog‘lanish so‘rovi kutilmoqda',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Ota-ona ko‘ra oladigan ma’lumotlar
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bog‘langandan keyin ko‘rishingiz mumkin:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                _PermissionItem(
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Ko‘rilgan videolar',
                ),
                _PermissionItem(
                  icon: Icons.search_rounded,
                  title: 'BilimHub ichidagi qidiruvlar',
                ),
                _PermissionItem(
                  icon: Icons.interests_rounded,
                  title: 'Qiziqishlar va o‘rganish faoliyati',
                ),
                _PermissionItem(
                  icon: Icons.schedule_rounded,
                  title: 'Ilovadan foydalanish vaqti',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Maxfiylik eslatmasi
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
                  Icons.lock_outline_rounded,
                  color: primaryColor,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bu ma’lumotlar faqat BilimHub ichidagi '
                        'faoliyatga tegishli. Farzand bog‘lanish '
                        'haqida xabardor qilinadi.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Tasdiqlash
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => showServerMessage(context),
              icon: const Icon(Icons.check_circle_outline_rounded),
              label: const Text('Bog‘lanishni tasdiqlash'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Rad etish
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => showServerMessage(context),
              icon: const Icon(Icons.close_rounded),
              label: const Text('So‘rovni rad etish'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _PermissionItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _PermissionItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF3468F5),
            size: 23,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}