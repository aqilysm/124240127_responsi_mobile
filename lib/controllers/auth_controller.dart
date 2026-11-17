import 'package:get/get.dart';
import '../services/session_service.dart';
import '../pages/login_page.dart';
import '../pages/main_page.dart';

class AuthController extends GetxController {
  final SessionService _session = SessionService();

  // ⭐ INTI: kredensial hardcode (ubah di sini)
  static const String validEmail = 'hihu@gmail.com';
  static const String validPassword = '123';

  final email = ''.obs;
  final isPasswordHidden = true.obs;

  Future<void> loadEmail() async {
    email.value = await _session.getEmail();
  }

  // ⭐ INTI: cocokkan input dengan kredensial hardcode
  Future<void> login(String emailInput, String password) async {
    final e = emailInput.trim();

    if (e == validEmail && password == validPassword) {
      await _session.saveSession(e);
      email.value = e;
      Get.offAll(() => const MainPage());
    } else {
      Get.snackbar(
        'Login Gagal',
        'Email atau password salah',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ⭐ INTI: logout
  Future<void> logout() async {
    await _session.clearSession();
    email.value = '';
    Get.offAll(() => const LoginPage());
  }
}