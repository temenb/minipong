import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();
  StorageService._internal();

  Future<void> saveList(String key, List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = list.map((e) => json.encode(e)).toList();
    await prefs.setStringList(key, jsonList);
  }

  Future<List<Map<String, dynamic>>> loadList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(key) ?? [];
    return jsonList.map((jsonStr) => json.decode(jsonStr) as Map<String, dynamic>).toList();
  }
}

