import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Player {
  final String name;
  bool isActive;
  Player(this.name, {this.isActive = true});

  Map<String, dynamic> toJson() => {'name': name, 'isActive': isActive};
  static Player fromJson(Map<String, dynamic> json) =>
      Player(json['name'], isActive: json['isActive'] ?? true);
}

class PlayerRepository {
  static const String _key = 'all_players_v2';
  static const String _legacyKey = 'all_players';

  Future<List<Player>> loadAllPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key);
    if (raw != null && raw.isNotEmpty) {
      // New format: List of JSON strings
      return raw
          .map((str) => Player.fromJson(Map<String, dynamic>.from(jsonDecode(str))))
          .toList();
    }
    // Try legacy format: List<String>
    final legacyRaw = prefs.getStringList(_legacyKey);
    if (legacyRaw != null && legacyRaw.isNotEmpty) {
      final players = legacyRaw.map((name) => Player(name, isActive: true)).toList();
      await saveAllPlayers(players); // Migrate to new format
      return players;
    }
    return [];
  }

  Future<void> saveAllPlayers(List<Player> players) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = players.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_key, raw);
  }

  Future<void> addPlayer(String name) async {
    final players = await loadAllPlayers();
    if (players.any((p) => p.name == name)) return;
    players.add(Player(name));
    await saveAllPlayers(players);
  }

  Future<void> setPlayerActive(String name, bool isActive) async {
    final players = await loadAllPlayers();
    for (var p in players) {
      if (p.name == name) p.isActive = isActive;
    }
    await saveAllPlayers(players);
  }
}
