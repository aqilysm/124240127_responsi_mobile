import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';

class ApiService {
  static const String _baseUrl = 'https://www.freetogame.com/api';

  // ⭐ INTI: daftar semua game
  Future<List<Game>> fetchGames() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/games'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Game.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat game (${response.statusCode})');
    }
  }

  // ⭐ INTI: detail game, id dikirim lewat query (?id=)
  Future<Game> fetchGameDetail(int id) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/game?id=$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      return Game.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat detail (${response.statusCode})');
    }
  }
}