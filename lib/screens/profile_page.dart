import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_page.dart';
import 'family_link_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color primaryColor = Color(0xFF3468F5);

  String fullName = 'Foydalanuvchi';
  String educationLevel = 'BilimHub a’zosi';
  String birthDate = '';
  String about = '';
  String? photoPath;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  // Telefon xotirasidan profilni yuklash
  Future<void> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!mounted) return;

      final name = prefs.getString('name') ?? '';
      final surname = prefs.getString('surname') ?? '';

      final savedPhoto = prefs.getString('profilePhotoPath');

      String? validPhoto;

      if (savedPhoto != null &&
          savedPhoto.isNotEmpty &&
          await File(savedPhoto).exists()) {
        validPhoto = savedPhoto;
      }

      if (!mounted) return;

      setState(() {
        fullName = '$name $surname'.trim();

        if (fullName.isEmpty) {
          fullName = 'Foydalanuvchi';
        }

        educationLevel =
            prefs.getString('educationLevel') ?? 'BilimHub a’zosi';

        birthDate = prefs.getString('birthDate') ?? '';
        about = prefs.getString('about') ?? '';
        photoPath = validPhoto;
      });
    } catch (e) {
      debugPrint('Profilni yuklashda xatolik: $e');
    }
  }

  // Profilni tahrirlash
  Future<void> openEditProfile() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfilePage(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        final name = result['name'] ?? '';
        final surname = result['surname'] ?? '';

        fullName = '$name $surname'.trim();

        if (fullName.isEmpty) {
          fullName = 'Foydalanuvchi';
        }

        educationLevel =
            result['educationLevel'] ?? 'BilimHub a’zosi';

        birthDate = result['birthDate'] ?? '';
        about = result['about'] ?? '';

        final savedPhoto = result['photoPath'] ?? '';
        photoPath = savedPhoto.isEmpty ? null : savedPhoto;
      });
    }
  }

  // Oila bilan bog‘lanish sahifasi
  void openFamilyLink() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FamilyLinkPage(),
      ),
    );
  }

  Widget buildProfileAvatar() {
    final hasPhoto = photoPath != null &&
        File(photoPath!).existsSync();

    return CircleAvatar(
      radius: 42,
      backgroundColor: const Color(0xFFE5EDFF),
      backgroundImage: hasPhoto ? FileImage(File(photoPath!)) : null,
      child: hasPhoto
          ? null
          : const Icon(
        Icons.person,
        size: 48,
        color: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Mening profilim',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  buildProfileAvatar(),

                  const SizedBox(height: 12),

                  Text(
                    fullName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    educationLevel,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  if (birthDate.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text('Tug‘ilgan sana: $birthDate'),
                  ],

                  if (about.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      about,
                      textAlign: TextAlign.center,
                    ),
                  ],

                  const SizedBox(height: 18),

                  OutlinedButton.icon(
                    onPressed: openEditProfile,
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Profilni tahrirlash'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Mening rivojlanishim',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const _ProfileItem(
              icon: Icons.school_rounded,
              title: 'Ta’lim va bilimlarim',
              subtitle: 'Kurslar va o‘zlashtirilgan bilimlar',
            ),

            const _ProfileItem(
              icon: Icons.psychology_rounded,
              title: 'Ko‘nikmalarim',
              subtitle: 'Bilim va amaliy qobiliyatlar',
            ),

            const _ProfileItem(
              icon: Icons.emoji_events_rounded,
              title: 'Yutuqlarim',
              subtitle: 'Sertifikatlar va erishilgan natijalar',
            ),

            const _ProfileItem(
              icon: Icons.work_rounded,
              title: 'Ish va amaliyot tajribam',
              subtitle: 'Ish joylari va kasbiy tajriba',
            ),

            _ProfileItem(
              icon: Icons.family_restroom_rounded,
              title: 'Oila bilan bog‘lanish',
              subtitle: 'Ota-ona va farzand profillari',
              onTap: openFamilyLink,
            ),

            const _ProfileItem(
              icon: Icons.description_rounded,
              title: 'Mening resume’im',
              subtitle: 'Shaxsiy portfolio va tavsifnoma',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF0FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF3468F5),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}