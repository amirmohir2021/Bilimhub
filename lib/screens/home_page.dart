
import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/category_card.dart';
import '../widgets/course_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yuqori qism
          Row(
            children: [
              const Icon(
                Icons.auto_stories_rounded,
                color: Color(0xFF3468F5),
                size: 32,
              ),
              const SizedBox(width: 8),
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
                icon: const Icon(Icons.notifications_none_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Salomlashuv
          const Text(
            'Assalomu alaykum! 👋',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF20345C),
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Bugun nimalarni o‘rganamiz?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8792A5),
            ),
          ),

          const SizedBox(height: 20),

          // Qidiruv
          TextField(
            decoration: InputDecoration(
              hintText: 'Kurs yoki mavzu qidirish...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3468F5),
                  Color(0xFF7195FF),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bilim olish vaqti!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'O‘rgan, yarat va o‘z iste’dodingni kashf et.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Yo‘nalishlar
          const SectionHeader(
            title: 'Yo‘nalishlar',
            subtitle: 'O‘zingga yoqqan yo‘nalishni tanla',
          ),

          const SizedBox(height: 15),

          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
            children: const [
              CategoryCard(
                title: 'Dasturlash',
                icon: Icons.code_rounded,
                color: Color(0xFF3468F5),
              ),
              CategoryCard(
                title: 'Matematika',
                icon: Icons.calculate_rounded,
                color: Color(0xFF16A085),
              ),
              CategoryCard(
                title: 'Tabiat',
                icon: Icons.eco_rounded,
                color: Color(0xFF27AE60),
              ),
              CategoryCard(
                title: 'San’at',
                icon: Icons.palette_rounded,
                color: Color(0xFFE67E22),
              ),
              CategoryCard(
                title: 'Robototexnika',
                icon: Icons.smart_toy_rounded,
                color: Color(0xFF8E44AD),
              ),
              CategoryCard(
                title: 'Kitoblar',
                icon: Icons.menu_book_rounded,
                color: Color(0xFFE74C3C),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Tavsiya etilgan kurslar
          const SectionHeader(
            title: 'Tavsiya etilgan kurslar',
            subtitle: 'Senga qiziqarli bo‘lishi mumkin',
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CourseCard(
                  title: 'Dasturlash asoslari',
                  description: 'Boshlang‘ich daraja',
                  icon: Icons.code_rounded,
                ),
                SizedBox(width: 12),
                CourseCard(
                  title: 'Matematika olami',
                  description: 'Qiziqarli masalalar',
                  icon: Icons.calculate_rounded,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
