import 'package:get/get.dart';
import '../models/game_model.dart';
import '../services/api_service.dart';
import '../services/library_service.dart';

class DetailController extends GetxController {
  final int gameId;
  DetailController(this.gameId);

  final ApiService _api = ApiService();
  final LibraryService _library = LibraryService();

  final game = Rxn<Game>();
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final isOwned = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetail();
  }

  // ⭐ INTI: fetch detail by id + cek status kepemilikan
  Future<void> fetchDetail() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      game.value = await _api.fetchGameDetail(gameId);
      isOwned.value = _library.isOwned(gameId);
    } catch (e) {
      errorMessage.value = 'Gagal memuat detail. Periksa koneksi internet.';
    } finally {
      isLoading.value = false;
    }
  }

  // ⭐ INTI: tombol Get, simpan ke library (Hive)
  Future<void> getGame() async {
    final data = game.value;
    if (data == null || isOwned.value) return;

    await _library.add(data);
    isOwned.value = true;
    Get.snackbar('Library', '${data.title} ditambahkan ke library',
        snackPosition: SnackPosition.BOTTOM);
  }
}