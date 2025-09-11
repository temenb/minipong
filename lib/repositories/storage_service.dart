import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();
  StorageService._internal();

  Future<void> saveList(String key, List<Map<String, dynamic>> list) async {

    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1');
    print('[StorageService.saveList] start, key: $key, list.length: ${list.length}');
    final prefs = await SharedPreferences.getInstance();
    print('[StorageService.saveList] SharedPreferences obtained');
    final jsonList = list.map((e) => json.encode(e)).toList();
    print('[StorageService.saveList] jsonList encoded, length: ${jsonList.length}');
    await prefs.setStringList(key, jsonList);
    print('[StorageService.saveList] setStringList finished');
  }

  Future<List<Map<String, dynamic>>> loadList(String key) async {
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1');
    print('[StorageService.loadList] start, key: $key');
    final prefs = await SharedPreferences.getInstance();
    print('[StorageService.loadList] SharedPreferences obtained');
    final jsonList = prefs.getStringList(key) ?? [];
    print('[StorageService.loadList] jsonList loaded, length: ${jsonList.length}');
    final decoded = jsonList.map((jsonStr) {
      try {
        final map = json.decode(jsonStr) as Map<String, dynamic>;
        print('[StorageService.loadList] decoded item: $map');
        return map;
      } catch (e) {
        print('[StorageService.loadList] decode error: $e, jsonStr: $jsonStr');
        return <String, dynamic>{};
      }
    }).toList();
    print('[StorageService.loadList] all items decoded, length: ${decoded.length}');
    return decoded;
  }
}
