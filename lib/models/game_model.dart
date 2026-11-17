class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final String description;
  final List<String> screenshots;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    this.publisher = '-',
    this.developer = '-',
    this.releaseDate = '-',
    this.description = '',
    this.screenshots = const [],
  });

  // ⭐ INTI PARSING: JSON API -> object Game
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'] ?? '-',
      thumbnail: json['thumbnail'] ?? '',
      genre: json['genre'] ?? '-',
      platform: json['platform'] ?? '-',
      publisher: json['publisher'] ?? '-',
      developer: json['developer'] ?? '-',
      releaseDate: json['release_date'] ?? '-',
      // endpoint list hanya punya short_description, detail punya description
      description: json['description'] ?? json['short_description'] ?? '',
      // screenshots berupa list of {id, image}, kita ambil url image saja
      screenshots: (json['screenshots'] as List? ?? [])
          .map((e) => e['image'].toString())
          .toList(),
    );
  }

  // Untuk disimpan ke Hive (object -> Map)
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'thumbnail': thumbnail,
        'genre': genre,
        'platform': platform,
        'publisher': publisher,
        'developer': developer,
        'releaseDate': releaseDate,
        'description': description,
        'screenshots': screenshots,
      };

  // Dari Hive (Map -> object)
  factory Game.fromMap(Map map) {
    return Game(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
      genre: map['genre'],
      platform: map['platform'],
      publisher: map['publisher'] ?? '-',
      developer: map['developer'] ?? '-',
      releaseDate: map['releaseDate'] ?? '-',
      description: map['description'] ?? '',
      screenshots: List<String>.from(map['screenshots'] ?? []),
    );
  }
}