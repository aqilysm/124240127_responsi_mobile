import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/library_controller.dart';
import 'home_page.dart';
import 'library_page.dart';
import 'profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller dibuat di sini supaya Home, Library, dan Profile
    // bisa memakai instance yang sama lewat Get.find
    Get.put(HomeController());
    Get.put(LibraryController());

    final currentIndex = 0.obs;
    final pages = [
      const HomePage(),
      const LibraryPage(),
      const ProfilePage(),
    ];

    return Obx(() => Scaffold(
          // IndexedStack menjaga state tiap tab
          body: IndexedStack(index: currentIndex.value, children: pages),

          // ⭐ INTI: BottomNavigationBar (Home, Library, Profile)
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex.value,
            onTap: (i) => currentIndex.value = i,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle), label: 'Library'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }
}