import 'package:get/get.dart';
import '../models/game_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final ApiService _api = ApiService();

  final games = <Game>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGames();
  }

  // ⭐ INTI: ambil data, atur loading
  Future<void> fetchGames() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      games.assignAll(await _api.fetchGames());
    } catch (e) {
      errorMessage.value = 'Gagal memuat data. Periksa koneksi internet.';
    } finally {
      isLoading.value = false;
    }
  }
}