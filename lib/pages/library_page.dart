import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/library_controller.dart';
import 'detail_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LibraryController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Anda',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.games.isEmpty) {
          return const Center(
            child: Text('Library masih kosong',
                style: TextStyle(color: Colors.grey)),
          );
        }

        // ⭐ INTI 1: list game dari Hive
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.games.length,
          itemBuilder: (context, index) {
            final game = controller.games[index];

            return GestureDetector(
              // ⭐ INTI 2: klik -> Detail Page
              onTap: () => Get.to(() => DetailPage(gameId: game.id)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 72,
                      child: Image.network(
                        game.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(game.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(game.genre,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ),
                          const SizedBox(height: 4),
                          Text(game.platform,
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ),
                    // ⭐ INTI 3: tombol delete
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.remove(game),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}