import 'dart:async';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/game_model.dart';
import '../services/library_service.dart';

class LibraryController extends GetxController {
  final LibraryService _service = LibraryService();

  final games = <Game>[].obs;
  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    load();
    // ⭐ INTI: dengarkan perubahan box. Library dan Profile otomatis update
    // saat game ditambah dari Detail atau dihapus dari Library.
    _subscription = Hive.box('library').watch().listen((_) => load());
  }

  void load() {
    games.assignAll(_service.getAll());
  }

  // ⭐ INTI: hapus game dari library
  Future<void> remove(Game game) async {
    await _service.remove(game.id);
    Get.snackbar('Library', '${game.title} dihapus dari library',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}