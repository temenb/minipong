import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_models.dart';

class GameHistoryRepository {
  static const String _storageKey = 'savedGames';

  Future<List<GameHistoryEntry>> loadSavedGames() async {
    final prefs = await SharedPreferences.getInstance();
    final gamesJson = prefs.getStringList(_storageKey) ?? [];
    return gamesJson.map((game) {
      final map = jsonDecode(game) as Map<String, dynamic>;
      return GameHistoryEntry.fromJson(map);
    }).toList();
  }

  Future<void> saveCurrentGame(GameHistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final gamesJson = prefs.getStringList(_storageKey) ?? [];
    gamesJson.insert(0, jsonEncode(entry.toJson()));
    await prefs.setStringList(_storageKey, gamesJson);
  }
}

