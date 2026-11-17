import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyIsLogin = 'isLogin';
  static const String _keyEmail = 'email';

  // ⭐ INTI: simpan session login
  Future<void> saveSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLogin, true);
    await prefs.setString(_keyEmail, email);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLogin) ?? false;
  }

  // Dipakai Profile Page
  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail) ?? '';
  }

  // ⭐ INTI: hapus session saat logout
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLogin);
    await prefs.remove(_keyEmail);
  }
}