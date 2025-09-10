import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Player {
  final String id;
  final String name;
  bool isActive;

  Player(this.name, {String? id, this.isActive = true}) : id = id ?? Uuid().v4();

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'isActive': isActive};

  static Player fromJson(Map<String, dynamic> json) =>
      Player(json['name'], id: json['id'], isActive: json['isActive'] ?? false);
}

class PlayerRepository {
  static final PlayerRepository instance = PlayerRepository._internal();

  PlayerRepository._internal();

  static const String _storageKey = 'players_v3';
  final List<Player> _players = [];

  Future<List<Player>> loadAllPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final playersJson = prefs.getStringList(_storageKey);
    _players.clear();
    if (playersJson != null) {
      _players.addAll(playersJson.map((str) => Player.fromJson(Map<String, dynamic>.from(jsonDecode(str)))));
    }
    return List<Player>.from(_players);
  }

  Future<void> saveAllPlayers(List<Player> players) async {
    final prefs = await SharedPreferences.getInstance();
    final playersJson = players.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_storageKey, playersJson);
    _players
      ..clear()
      ..addAll(players);
  }

  Future<void> addPlayer(String name) async {
    await loadAllPlayers();
    if (_players.any((p) => p.name == name)) return;
    _players.add(Player(name));
    await saveAllPlayers(_players);
  }

  Future<void> setPlayerActive(String id, bool isActive) async {
    await loadAllPlayers();
    for (var p in _players) {
      if (p.id == id) {
        p.isActive = isActive;
        break;
      }
    }
    await saveAllPlayers(_players);
  }

  Player? getPlayerById(String id) {
    if (id.isEmpty) return null;
    try {
      return _players.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Player> get activePlayers => _players.where((p) => p.isActive).toList();
  List<String> get activePlayerNames => activePlayers.map((p) => p.name).toList();
  List<String> get activePlayerIds => activePlayers.map((p) => p.id).toList();
}
