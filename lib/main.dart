import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/auth_controller.dart';
import 'services/session_service.dart';
import 'pages/login_page.dart';
import 'pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ⭐ INTI: init Hive dan buka box library
  await Hive.initFlutter();
  await Hive.openBox('library');

  // AuthController dibuat di awal supaya LoginPage dan ProfilePage
  // cukup memakai Get.find (tidak error saat auto-login)
  final auth = Get.put(AuthController());
  await auth.loadEmail();

  // ⭐ INTI: cek session SharedPreferences
  final isLogin = await SessionService().isLoggedIn();

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hydra Games',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: isLogin ? const MainPage() : const LoginPage(),
    );
  }
}