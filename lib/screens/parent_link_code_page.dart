
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'family_link_confirmation_page.dart';

class ParentLinkCodePage extends StatefulWidget {
  const ParentLinkCodePage({super.key});

  @override
  State<ParentLinkCodePage> createState() =>
      _ParentLinkCodePageState();
}

class _ParentLinkCodePageState extends State<ParentLinkCodePage> {
  static const Color primaryColor = Color(0xFF3468F5);
  static const String codeKey = 'bilimhub_family_link_code';

  final TextEditingController codeController =
  TextEditingController();

  bool isChecking = false;

  Future<void> checkCode() async {
    final code = codeController.text.trim();

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Iltimos, 6 xonali kodni kiriting.'),
        ),
      );
      return;
    }

    setState(() {
      isChecking = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCode = prefs.getString(codeKey);

      if (!mounted) return;

      setState(() {
        isChecking = false;
      });

      if (savedCode == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Farzand hisobida hali kod yaratilmagan.',
            ),
          ),
        );
        return;
      }

      if (code != savedCode) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kod noto‘g‘ri. Qayta tekshiring.'),
          ),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const FamilyLinkConfirmationPage(),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        isChecking = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kodni tekshirishda xatolik yuz berdi.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('Farzandni bog‘lash'),
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.supervisor_account_rounded,
            size: 65,
            color: primaryColor,
          ),
          const SizedBox(height: 15),
          const Text(
            'Farzandingizni bog‘lang',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Farzandingizning BilimHub hisobida '
                'yaratilgan 6 xonali kodni kiriting.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bog‘lash kodi',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10,
                  ),
                  decoration: InputDecoration(
                    hintText: '000000',
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFFF6F8FC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: isChecking ? null : checkCode,
                    icon: const Icon(Icons.link_rounded),
                    label: Text(
                      isChecking
                          ? 'Tekshirilmoqda...'
                          : 'Kodni tekshirish',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                    'Kod hozircha ushbu qurilmada saqlangan '
                        'ma’lumot bilan tekshiriladi. Haqiqiy '
                        'hisoblararo bog‘lash uchun server '
                        'tizimi kerak bo‘ladi.',
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
