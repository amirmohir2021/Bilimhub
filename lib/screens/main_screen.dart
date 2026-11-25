
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'simple_page.dart';
import 'profile_page.dart';


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
  ProfilePage(),

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
