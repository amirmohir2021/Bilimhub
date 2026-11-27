
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  static const Color primaryColor = Color(0xFF3468F5);

  final Map<String, List<String>> categories = {
    'Dasturlash va IT': [
      'Python', 'Flutter', 'Web dasturlash', 'Sun’iy intellekt',
      'Robototexnika', 'Kiberxavfsizlik', 'O‘yin yaratish'
    ],
    'Matematika va mantiq': [
      'Algebra', 'Geometriya', 'Mantiqiy masalalar',
      'Olimpiadalar', 'Statistika', 'Moliyaviy savodxonlik'
    ],
    'Fan va tadqiqot': [
      'Fizika', 'Kimyo', 'Biologiya', 'Astronomiya',
      'Ekologiya', 'Tajriba va tadqiqotlar'
    ],
    'San’at va dizayn': [
      'Rasm chizish', 'Grafik dizayn', 'UI/UX dizayn',
      '3D modellashtirish', 'Animatsiya', 'Fotografiya'
    ],
    'Musiqa va ijod': [
      'Qo‘shiq aytish', 'Musiqa asboblari', 'Musiqa yaratish',
      'Raqs', 'Teatr', 'Aktyorlik', 'Ijodiy yozuv'
    ],
    'Til va adabiyot': [
      'O‘zbek tili', 'Ingliz tili', 'Rus tili',
      'Boshqa tillar', 'Kitob o‘qish', 'She’riyat', 'Hikoya yozish'
    ],
    'Sport va salomatlik': [
      'Futbol', 'Shaxmat', 'Suzish', 'Kurash',
      'Gimnastika', 'Yugurish', 'Sog‘lom turmush'
    ],
    'Muhandislik va texnika': [
      'Elektronika', 'Mexanika', 'Qurilish',
      '3D loyihalash', 'Avtomatlashtirish', 'Ixtirochilik'
    ],
    'Biznes va tadbirkorlik': [
      'Biznes g‘oyalar', 'Marketing', 'Boshqaruv',
      'Moliya', 'Savdo', 'Loyiha boshqaruvi'
    ],
    'Tabiat va hayvonot': [
      'O‘simliklar', 'Hayvonlar', 'Tabiatni asrash',
      'Geografiya', 'Sayohat', 'Qishloq xo‘jaligi'
    ],
    'Jamiyat va inson': [
      'Psixologiya', 'Tarix', 'Huquq',
      'Yetakchilik', 'Muloqot', 'Jamoaviy ish', 'Ko‘ngillilik'
    ],
    'Hayotiy ko‘nikmalar': [
      'Pazandachilik', 'Tikuvchilik', 'Uy ishlari',
      'Vaqtni boshqarish', 'Birinchi yordam', 'Kundalik ko‘nikmalar'
    ],
  };

  final Map<String, IconData> categoryIcons = {
    'Dasturlash va IT': Icons.computer_rounded,
    'Matematika va mantiq': Icons.calculate_rounded,
    'Fan va tadqiqot': Icons.science_rounded,
    'San’at va dizayn': Icons.palette_rounded,
    'Musiqa va ijod': Icons.music_note_rounded,
    'Til va adabiyot': Icons.menu_book_rounded,
    'Sport va salomatlik': Icons.sports_soccer_rounded,
    'Muhandislik va texnika': Icons.precision_manufacturing_rounded,
    'Biznes va tadbirkorlik': Icons.business_center_rounded,
    'Tabiat va hayvonot': Icons.nature_rounded,
    'Jamiyat va inson': Icons.people_alt_rounded,
    'Hayotiy ko‘nikmalar': Icons.lightbulb_rounded,
  };

  final Set<String> selectedCategories = {};
  final Set<String> selectedTopics = {};
  final TextEditingController customController = TextEditingController();

  String discoveryChoice = '';

  @override
  void initState() {
    super.initState();
    loadInterests();
  }

  Future<void> loadInterests() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      selectedCategories.addAll(
        prefs.getStringList('interestCategories') ?? [],
      );

      selectedTopics.addAll(
        prefs.getStringList('interestTopics') ?? [],
      );

      customController.text =
          prefs.getString('customInterest') ?? '';

      discoveryChoice =
          prefs.getString('interestDiscoveryChoice') ?? '';
    });
  }

  Future<void> saveInterests() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      'interestCategories',
      selectedCategories.toList(),
    );

    await prefs.setStringList(
      'interestTopics',
      selectedTopics.toList(),
    );

    await prefs.setString(
      'customInterest',
      customController.text.trim(),
    );

    await prefs.setString(
      'interestDiscoveryChoice',
      discoveryChoice,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Qiziqishlaringiz saqlandi!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
        selectedTopics.removeAll(categories[category]!);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  void toggleTopic(String topic) {
    setState(() {
      if (!selectedTopics.add(topic)) {
        selectedTopics.remove(topic);
      }
    });
  }

  @override
  void dispose() {
    customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Qiziqishlarim',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.explore_rounded,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: 10),
                Text(
                  'Nimalarga qiziqasiz?',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'O‘zingizga yoqqan yo‘nalish va mavzularni tanlang. '
                      'Bir nechta variantni belgilashingiz mumkin.',
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Asosiy yo‘nalishlar',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...categories.entries.map((entry) {
            final selected =
            selectedCategories.contains(entry.key);

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: selected
                      ? primaryColor
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: ExpansionTile(
                key: PageStorageKey(entry.key),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFEAF0FF),
                  child: Icon(
                    categoryIcons[entry.key],
                    color: primaryColor,
                  ),
                ),
                title: Text(
                  entry.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${entry.value.where(selectedTopics.contains).length} ta mavzu tanlangan',
                ),
                trailing: Checkbox(
                  value: selected,
                  activeColor: primaryColor,
                  onChanged: (_) => toggleCategory(entry.key),
                ),
                childrenPadding:
                const EdgeInsets.fromLTRB(16, 0, 16, 12),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: entry.value.map((topic) {
                        final topicSelected =
                        selectedTopics.contains(topic);

                        return FilterChip(
                          label: Text(topic),
                          selected: topicSelected,
                          selectedColor:
                          const Color(0xFFDCE6FF),
                          checkmarkColor: primaryColor,
                          onSelected: (_) {
                            setState(() {
                              if (!selected) {
                                selectedCategories.add(entry.key);
                              }

                              toggleTopic(topic);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 20),

          const Text(
            'Hozircha aniq qiziqishingiz yo‘qmi?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          RadioGroup<String>(
            groupValue: discoveryChoice,
            onChanged: (value) {
              setState(() {
                discoveryChoice = value ?? '';
              });
            },
            child: Column(
              children: [
                _choiceTile(
                  'Hali bilmayman',
                  Icons.help_outline_rounded,
                ),
                _choiceTile(
                  'Yangi narsalarni sinab ko‘rmoqchiman',
                  Icons.explore_rounded,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Boshqa qiziqishim bor',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: customController,
            decoration: InputDecoration(
              hintText: 'Qiziqishingizni yozing...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: saveInterests,
              icon: const Icon(Icons.save_rounded),
              label: const Text(
                'Qiziqishlarni saqlash',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _choiceTile(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: RadioListTile<String>(
        value: title,
        secondary: Icon(icon, color: primaryColor),
        title: Text(title),
        activeColor: primaryColor,
      ),
    );
  }
}
