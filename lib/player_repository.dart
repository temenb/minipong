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
  static final PlayerRepository instance = PlayerRepository._internal();

  PlayerRepository._internal();

  static const String _storageKey = 'players_names_v2';
  final List<Player> _players = [];

  Future<List<Player>> loadAllPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final names = prefs.getStringList(_storageKey);
    if (_players.isNotEmpty) {
      return List<Player>.from(_players);
    }
    _players.clear();
    if (names != null) {
      _players.addAll(names.map((name) => Player(name, isActive: false)));
    }
    return List<Player>.from(_players);
  }

  Future<void> saveAllPlayers(List<Player> players) async {
    final prefs = await SharedPreferences.getInstance();
    final names = players.map((p) => p.name).toList();
    await prefs.setStringList(_storageKey, names);
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

  Future<void> setPlayerActive(String name, bool isActive) async {
    await loadAllPlayers();
    for (var p in _players) {
      if (p.name == name) {
        p.isActive = isActive;
        break;
      }
    }
    await saveAllPlayers(_players);
  }

  List<String> get activePlayerNames =>
      _players.where((p) => p.isActive).map((p) => p.name).toList();
}
