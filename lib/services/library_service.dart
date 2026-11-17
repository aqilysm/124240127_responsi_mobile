import 'package:hive_flutter/hive_flutter.dart';
import '../models/game_model.dart';

class LibraryService {
  // Box 'library' sudah dibuka di main.dart
  Box get _box => Hive.box('library');

  // ⭐ INTI: tambah game ke library
  Future<void> add(Game game) async {
    await _box.put(game.id, game.toMap());
  }

  // ⭐ INTI: hapus dari library
  Future<void> remove(int id) async {
    await _box.delete(id);
  }

  // Cek apakah game sudah dimiliki
  bool isOwned(int id) => _box.containsKey(id);

  // Ambil semua game di library
  List<Game> getAll() {
    return _box.values.map((e) => Game.fromMap(Map.from(e))).toList();
  }
}