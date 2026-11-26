
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildLinkCodePage extends StatefulWidget {
  const ChildLinkCodePage({super.key});

  @override
  State<ChildLinkCodePage> createState() => _ChildLinkCodePageState();
}

class _ChildLinkCodePageState extends State<ChildLinkCodePage> {
  static const Color primaryColor = Color(0xFF3468F5);
  static const String codeKey = 'bilimhub_family_link_code';

  String? generatedCode;
  bool isGenerating = false;

  @override
  void initState() {
    super.initState();
    loadSavedCode();
  }

  Future<void> loadSavedCode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(codeKey);

    if (!mounted) return;

    setState(() {
      generatedCode = savedCode;
    });
  }

  Future<void> generateCode() async {
    setState(() {
      isGenerating = true;
    });

    try {
      final random = Random.secure();
      final code = (100000 + random.nextInt(900000)).toString();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(codeKey, code);

      if (!mounted) return;

      setState(() {
        generatedCode = code;
        isGenerating = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        isGenerating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kod yaratishda xatolik yuz berdi.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final qrData = generatedCode == null
        ? null
        : 'BILIMHUB_LINK:$generatedCode';

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
                'sizning hisobingizni bog‘lashi mumkin.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),

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
                Text(
                  generatedCode ?? '------',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  generatedCode == null
                      ? 'Yangi kod yaratish tugmasini bosing'
                      : 'Kod ota-onangizga berish uchun tayyor',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: isGenerating ? null : generateCode,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(
                      isGenerating
                          ? 'Yaratilmoqda...'
                          : 'Yangi kod yaratish',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: generatedCode == null
                      ? const SizedBox(
                    width: 190,
                    height: 190,
                    child: Center(
                      child: Icon(
                        Icons.qr_code_2_rounded,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : QrImageView(
                    data: qrData!,
                    version: QrVersions.auto,
                    size: 190,
                    backgroundColor: Colors.white,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: primaryColor,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  generatedCode == null
                      ? 'QR-kod yaratish uchun avval kod yarating.'
                      : 'Ushbu QR-kod sizning bog‘lash kodingizni saqlaydi.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    height: 1.4,
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
                    'Bu hozircha telefon ichida ishlaydigan '
                        'namoyish mexanizmi. Haqiqiy xavfsiz bog‘lash '
                        'uchun server orqali tekshirish kerak.',
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
