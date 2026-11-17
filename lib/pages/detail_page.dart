import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';

class DetailPage extends StatelessWidget {
  final int gameId;
  const DetailPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    // tag = id supaya tiap game punya controller sendiri
    final controller = Get.put(
      DetailController(gameId),
      tag: gameId.toString(),
    );

    return Scaffold(
      // Tombol back otomatis karena dibuka dengan Get.to
      appBar: AppBar(title: const Text('Detail'), centerTitle: true),
      body: Obx(() {
        // Loading indicator
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
                  onPressed: controller.fetchDetail,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final game = controller.game.value!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ⭐ INTI 1: hero image (paling atas dan besar)
              Image.network(
                game.thumbnail,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  height: 220,
                  child: Center(child: Icon(Icons.broken_image, size: 64)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⭐ INTI 2: genre dan platform
                    Row(
                      children: [
                        _chip(game.genre),
                        const SizedBox(width: 8),
                        _chip(game.platform),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Nama game
                    Text(game.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // ⭐ INTI 3: tanggal rilis, publisher, developer
                    Row(
                      children: [
                        _info('Release Date', game.releaseDate),
                        _info('Publisher', game.publisher),
                        _info('Developer', game.developer),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ⭐ INTI 4: tombol Get, UI berbeda sesuai kepemilikan
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: controller.isOwned.value
                          ? ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: Colors.grey[700],
                                disabledForegroundColor: Colors.white,
                              ),
                              onPressed: null, // sudah dimiliki
                              icon: const Icon(Icons.check),
                              label: const Text('In Library'),
                            )
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: controller.getGame,
                              icon: const Icon(Icons.add),
                              label: const Text('Get'),
                            ),
                    ),
                    const SizedBox(height: 20),

                    // ⭐ INTI 5: screenshots (scroll horizontal)
                    const Text('Screenshots',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    game.screenshots.isEmpty
                        ? const Text('Tidak ada screenshot.',
                            style: TextStyle(color: Colors.grey))
                        : SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: game.screenshots.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, i) => ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  game.screenshots[i],
                                  width: 160,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const SizedBox(
                                          width: 160,
                                          child: Icon(Icons.broken_image)),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),

                    // ⭐ INTI 6: deskripsi
                    const Text('Overview',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                      game.description.isEmpty
                          ? 'Tidak ada deskripsi.'
                          : game.description,
                      style: const TextStyle(fontSize: 12, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Widget kecil untuk chip genre/platform
  Widget _chip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(text, style: const TextStyle(fontSize: 11)),
      );

  // Widget kecil untuk label + nilai (release date, publisher, developer)
  Widget _info(String label, String value) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 12)),
          ],
        ),
      );
}