import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/item.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const String _keyItems = 'uts_items';
  static const String _keyAuth = 'uts_auth';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Items CRUD
  static List<Item> loadItems() {
    final jsonStr = _prefs.getString(_keyItems);
    if (jsonStr == null) return [];
    try {
      return Item.listFromJson(jsonStr);
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveItems(List<Item> items) async {
    final jsonStr = Item.listToJson(items);
    await _prefs.setString(_keyItems, jsonStr);
  }

  static Future<void> addItem(String title, String description) async {
    final items = loadItems();
    final id = Uuid().v4();
    items.add(Item(id: id, title: title, description: description));
    await saveItems(items);
  }

  static Future<void> updateItem(Item updated) async {
    final items = loadItems();
    final idx = items.indexWhere((e) => e.id == updated.id);
    if (idx >= 0) {
      items[idx] = updated;
      await saveItems(items);
    }
  }

  static Future<void> deleteItem(String id) async {
    final items = loadItems();
    items.removeWhere((e) => e.id == id);
    await saveItems(items);
  }

  // Simple auth (register/login stored in prefs) -> for demo only (not secure)
  static Future<void> register(String username, String password) async {
    final data = json.encode({'username': username, 'password': password});
    await _prefs.setString(_keyAuth, data);
  }

  static bool login(String username, String password) {
    final s = _prefs.getString(_keyAuth);
    if (s == null) return false;
    final m = json.decode(s);
    if (m['username'] == username && m['password'] == password) {
      return true;
    }
    return false;
  }
}
