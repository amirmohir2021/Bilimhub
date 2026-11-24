
import 'package:flutter/material.dart';

void main() {
  runApp(const BilimHubApp());
}

class BilimHubApp extends StatelessWidget {
  const BilimHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BilimHub',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3468F5),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    SimplePage(
      title: 'Kashfiyot',
      subtitle: 'Yangi qiziqishlar va imkoniyatlarni kashf et!',
      icon: Icons.explore_rounded,
    ),
    SimplePage(
      title: 'Ta’lim',
      subtitle: 'Bilim olishni bugundan boshlaymiz!',
      icon: Icons.school_rounded,
    ),
    SimplePage(
      title: 'Hamjamiyat',
      subtitle: 'Do‘stlar bilan birgalikda o‘rganamiz!',
      icon: Icons.groups_rounded,
    ),
    SimplePage(
      title: 'Profil',
      subtitle: 'Shaxsiy sahifang va yutuqlaring.',
      icon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE5EDFF),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Bosh sahifa',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Kashfiyot',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school_rounded),
            label: 'Ta’lim',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Hamjamiyat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// BOSH SAHIFA

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const blue = Color(0xFF3468F5);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Yuqori qism
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.auto_stories_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'BilimHub',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF20345C),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      size: 27,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 21,
                    backgroundColor: Color(0xFFE5EDFF),
                    child: Icon(
                      Icons.person_rounded,
                      color: blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Salomlashuv
              const Text(
                'Assalomu alaykum! 👋',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D2D50),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Bugun qanday yangi bilimlarni kashf etamiz?',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF77839A),
                ),
              ),

              const SizedBox(height: 22),

              // Qidiruv
              TextField(
                decoration: InputDecoration(
                  hintText: 'Dars, kurs yoki mavzu qidirish...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3468F5),
                      Color(0xFF7198FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Katta orzular,\nkatta bilimlardan boshlanadi!',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'O‘rgan, yarat va o‘z iste’dodingni kashf et.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: blue,
                      ),
                      child: const Text('Boshlash'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Kategoriyalar
              const SectionHeader(
                title: 'Qiziqishlar',
                subtitle: 'O‘zingga yoqqan yo‘nalishni tanla',
              ),

              const SizedBox(height: 16),

              const Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  CategoryCard(
                    title: 'Dasturlash',
                    icon: Icons.code_rounded,
                    color: Color(0xFFE5EDFF),
                  ),
                  CategoryCard(
                    title: 'Matematika',
                    icon: Icons.calculate_rounded,
                    color: Color(0xFFFFEFD9),
                  ),
                  CategoryCard(
                    title: 'Tabiat',
                    icon: Icons.eco_rounded,
                    color: Color(0xFFE0F5E8),
                  ),
                  CategoryCard(
                    title: 'San’at',
                    icon: Icons.palette_rounded,
                    color: Color(0xFFFFE6ED),
                  ),
                  CategoryCard(
                    title: 'Robototexnika',
                    icon: Icons.smart_toy_rounded,
                    color: Color(0xFFEDE5FF),
                  ),
                  CategoryCard(
                    title: 'Kitoblar',
                    icon: Icons.menu_book_rounded,
                    color: Color(0xFFFFF4D9),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Tavsiya etilgan kurslar
              const SectionHeader(
                title: 'Tavsiya etiladi',
                subtitle: 'Senga qiziqarli bo‘lishi mumkin',
              ),

              const SizedBox(height: 16),

              const CourseCard(
                title: 'Dasturlash asoslari',
                description: 'Dasturlash olamiga ilk qadam',
                icon: Icons.code_rounded,
                color: Color(0xFFE5EDFF),
                level: 'Boshlang‘ich',
              ),

              const SizedBox(height: 12),

              const CourseCard(
                title: 'Matematika olami',
                description: 'Mantiqiy fikrlashni rivojlantir',
                icon: Icons.functions_rounded,
                color: Color(0xFFFFEFD9),
                level: 'Barcha darajalar',
              ),

              const SizedBox(height: 24),
            ]),
          ),
        ),
      ],
    );
  }
}

// BO‘LIM SARLAVHASI

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color(0xFF20345C),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF8792A5),
          ),
        ),
      ],
    );
  }
}

// KATEGORIYA KARTASI

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 52) / 2,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF3468F5)),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// KURS KARTASI

class CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String level;

  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: 30,
              color: const Color(0xFF3468F5),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8792A5),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  level,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF3468F5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xFF8792A5),
          ),
        ],
      ),
    );
  }
}

// QOLGAN BO‘LIMLAR UCHUN BOSHLANG‘ICH EKRAN

class SimplePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const SimplePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 75,
              color: const Color(0xFF3468F5),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF20345C),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF8792A5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
