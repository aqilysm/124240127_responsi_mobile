import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Games',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
        // ⭐ INTI 1: loading indicator
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.fetchGames,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        // ⭐ INTI 2: ListView (thumbnail, nama, genre, platform)
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.games.length,
          itemBuilder: (context, index) {
            final game = controller.games[index];

            return GestureDetector(
              // ⭐ INTI 3: klik -> Detail Page
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
                    // Thumbnail
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
                    // Nama, genre, platform
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                    const SizedBox(width: 4),
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