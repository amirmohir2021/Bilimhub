import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  DateTime? birthDate;
  String educationLevel = 'Maktab o‘quvchisi';

  bool isLoading = true;
  bool isSaving = false;

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

  // Saqlangan ma'lumotlarni yuklash
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
    } catch (e) {
      debugPrint('Profilni yuklashda xatolik: $e');
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Tug'ilgan sanani tanlash
  Future<void> selectBirthDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(2010),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        birthDate = selectedDate;
      });
    }
  }

  // Profilni saqlash
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

      final formattedDate = birthDate == null
          ? ''
          : '${birthDate!.day}.${birthDate!.month}.${birthDate!.year}';

      await prefs.setString('name', name);
      await prefs.setString('surname', surname);
      await prefs.setString('birthDate', formattedDate);
      await prefs.setString('educationLevel', educationLevel);
      await prefs.setString('about', about);

      // Saqlangan ma'lumotlarni qayta tekshirish
      final savedName = prefs.getString('name');
      final savedSurname = prefs.getString('surname');

      if (savedName != name || savedSurname != surname) {
        throw Exception('Ma’lumotlarni tekshirish muvaffaqiyatsiz.');
      }

      debugPrint('PROFIL MUVAFFAQIYATLI SAQLANDI');
      debugPrint('Ism: $savedName');
      debugPrint('Familiya: $savedSurname');

      if (!mounted) return;

      Navigator.pop(context, {
        'name': name,
        'surname': surname,
        'birthDate': formattedDate,
        'educationLevel': educationLevel,
        'about': about,
      });
    } catch (e) {
      debugPrint('SAQLASH XATOLIGI: $e');

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
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        padding: const EdgeInsets.all(20),
        children: [
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
              backgroundColor: const Color(0xFF3468F5),
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