import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/library_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final library = Get.find<LibraryController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: Colors.grey[800],
              child: const Icon(Icons.person, size: 48, color: Colors.white70),
            ),
            const SizedBox(height: 32),

            // ⭐ INTI 1: email dari SharedPreferences
            Obx(() => _row('Email:', auth.email.value)),
            const SizedBox(height: 10),

            // ⭐ INTI 2: jumlah game dari Hive
            Obx(() => _row('Games Dimiliki:', '${library.games.length}')),
            const SizedBox(height: 24),

            // ⭐ INTI 3: tombol logout
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: auth.logout,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      );
}