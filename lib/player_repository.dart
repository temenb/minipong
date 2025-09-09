import 'package:shared_preferences/shared_preferences.dart';

class PlayerRepository {
  static const String _key = 'all_players';

  Future<List<String>> loadAllPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addPlayer(String name) async {
    if (name.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final players = prefs.getStringList(_key) ?? [];
    if (!players.contains(name)) {
      players.add(name);
      await prefs.setStringList(_key, players);
    }
  }

  Future<void> removePlayer(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final players = prefs.getStringList(_key) ?? [];
    players.remove(name);
    await prefs.setStringList(_key, players);
  }
}

