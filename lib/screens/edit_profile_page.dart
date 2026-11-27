import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static const Color primaryColor = Color(0xFF3468F5);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  DateTime? birthDate;
  String educationLevel = 'Maktab o‘quvchisi';
  String? photoPath;

  bool isLoading = true;
  bool isSaving = false;
  bool isPickingImage = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  Future<void> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      nameController.text = prefs.getString('name') ?? '';
      surnameController.text = prefs.getString('surname') ?? '';
      aboutController.text = prefs.getString('about') ?? '';

      educationLevel = prefs.getString('educationLevel') ??
          'Maktab o‘quvchisi';

      final savedDate = prefs.getString('birthDate') ?? '';

      if (savedDate.isNotEmpty) {
        final parts = savedDate.split('.');

        if (parts.length == 3) {
          birthDate = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      }

      final savedPhoto = prefs.getString('profilePhotoPath');

      if (savedPhoto != null &&
          savedPhoto.isNotEmpty &&
          await File(savedPhoto).exists()) {
        photoPath = savedPhoto;
      }
    } catch (e) {
      debugPrint('Profilni yuklashda xatolik: $e');
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Galereya yoki kameradan rasm tanlash
  Future<void> pickProfilePhoto(ImageSource source) async {
    if (isPickingImage) return;

    try {
      setState(() {
        isPickingImage = true;
      });

      final XFile? selectedImage = await imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (selectedImage == null) return;

      final appDirectory = await getApplicationDocumentsDirectory();

      final profileDirectory = Directory(
        '${appDirectory.path}/profile_photos',
      );

      if (!await profileDirectory.exists()) {
        await profileDirectory.create(recursive: true);
      }

      final newPath =
          '${profileDirectory.path}/profile_${DateTime.now().microsecondsSinceEpoch}.jpg';

      final savedImage = await File(selectedImage.path).copy(newPath);

      if (!mounted) return;

      setState(() {
        photoPath = savedImage.path;
      });
    } catch (e) {
      debugPrint('Rasm tanlashda xatolik: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rasmni tanlashda xatolik yuz berdi.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isPickingImage = false;
        });
      }
    }
  }

  // Rasm uchun menyu
  void showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Profil rasmini o‘zgartirish',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: primaryColor,
                  ),
                  title: const Text('Galereyadan tanlash'),
                  onTap: () {
                    Navigator.pop(context);
                    pickProfilePhoto(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: primaryColor,
                  ),
                  title: const Text('Kamera orqali suratga olish'),
                  onTap: () {
                    Navigator.pop(context);
                    pickProfilePhoto(ImageSource.camera);
                  },
                ),
                if (photoPath != null)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Profil rasmini olib tashlash',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        photoPath = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> selectBirthDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(2010),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null && mounted) {
      setState(() {
        birthDate = selectedDate;
      });
    }
  }

  // Profil ma'lumotlarini saqlash
  Future<void> saveProfile() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      final name = nameController.text.trim();
      final surname = surnameController.text.trim();
      final about = aboutController.text.trim();

      final oldPhotoPath =
          prefs.getString('profilePhotoPath') ?? '';

      final formattedDate = birthDate == null
          ? ''
          : '${birthDate!.day}.${birthDate!.month}.${birthDate!.year}';

      await prefs.setString('name', name);
      await prefs.setString('surname', surname);
      await prefs.setString('birthDate', formattedDate);
      await prefs.setString('educationLevel', educationLevel);
      await prefs.setString('about', about);
      await prefs.setString('profilePhotoPath', photoPath ?? '');

      final savedName = prefs.getString('name');
      final savedSurname = prefs.getString('surname');

      if (savedName != name || savedSurname != surname) {
        throw Exception('Ma’lumotlarni tekshirish muvaffaqiyatsiz.');
      }

      // Eski surat endi ishlatilmasa, uni xotiradan o‘chirish
      if (oldPhotoPath.isNotEmpty &&
          oldPhotoPath != photoPath) {
        final oldFile = File(oldPhotoPath);

        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }

      if (!mounted) return;

      Navigator.pop(context, {
        'name': name,
        'surname': surname,
        'birthDate': formattedDate,
        'educationLevel': educationLevel,
        'about': about,
        'photoPath': photoPath ?? '',
      });
    } catch (e) {
      debugPrint('Profilni saqlashda xatolik: $e');

      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saqlashda xatolik: $e'),
        ),
      );
    }
  }

  Widget buildPhotoSection() {
    final hasPhoto = photoPath != null &&
        File(photoPath!).existsSync();

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xFFE5EDFF),
                backgroundImage:
                hasPhoto ? FileImage(File(photoPath!)) : null,
                child: hasPhoto
                    ? null
                    : const Icon(
                  Icons.person,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: isPickingImage ? null : showPhotoOptions,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: isPickingImage
                        ? const Padding(
                      padding: EdgeInsets.all(9),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 19,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: isPickingImage ? null : showPhotoOptions,
            child: const Text('Profil rasmini o‘zgartirish'),
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
        title: const Text('Profilni tahrirlash'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(20),
        children: [
          buildPhotoSection(),

          const SizedBox(height: 25),

          _buildLabel('Ism'),
          _buildTextField(
            nameController,
            'Ismingizni kiriting',
          ),

          const SizedBox(height: 18),

          _buildLabel('Familiya'),
          _buildTextField(
            surnameController,
            'Familiyangizni kiriting',
          ),

          const SizedBox(height: 18),

          _buildLabel('Tug‘ilgan sana'),

          InkWell(
            onTap: selectBirthDate,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: _fieldDecoration(),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 12),
                  Text(
                    birthDate == null
                        ? 'Tug‘ilgan sanani tanlang'
                        : '${birthDate!.day}.${birthDate!.month}.${birthDate!.year}',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          _buildLabel('Ta’lim bosqichi'),

          DropdownButtonFormField<String>(
            initialValue: educationLevel,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            items: [
              'Maktab o‘quvchisi',
              'Talaba',
              'Mustaqil o‘rganuvchi',
              'Ishlayman',
            ].map((level) {
              return DropdownMenuItem<String>(
                value: level,
                child: Text(level),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  educationLevel = value;
                });
              }
            },
          ),

          const SizedBox(height: 18),

          _buildLabel('O‘zim haqimda'),

          TextField(
            controller: aboutController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'O‘zingiz haqingizda qisqacha yozing',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 28),

          ElevatedButton(
            onPressed: isSaving ? null : saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: isSaving
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : const Text(
              'Saqlash',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    );
  }
}