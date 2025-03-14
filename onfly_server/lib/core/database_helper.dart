import 'dart:convert';
import 'dart:io';

class DatabaseHelper {
  static final String _dbFile =
      '${Directory.current.path}/storage/database.json';

  static Future<Map<String, dynamic>> _readDatabase() async {
    final file = File(_dbFile);

    if (!await file.exists()) {
      await file.writeAsString(jsonEncode({"users": [], "expenses": []}));
    }

    final content = await file.readAsString();
    return jsonDecode(content);
  }

  static Future<void> _writeDatabase(Map<String, dynamic> data) async {
    final file = File(_dbFile);
    await file.writeAsString(jsonEncode(data, toEncodable: _jsonEncodeHelper));
  }

  static dynamic _jsonEncodeHelper(dynamic item) {
    if (item is DateTime) return item.toIso8601String();
    return item;
  }

  static Future<List<Map<String, dynamic>>> getCollection(
    String collection,
  ) async {
    final db = await _readDatabase();
    return List<Map<String, dynamic>>.from(db[collection] ?? []);
  }

  static Future<void> addToCollection(
    String collection,
    Map<String, dynamic> item,
  ) async {
    final db = await _readDatabase();
    (db[collection] as List).add(item);
    await _writeDatabase(db);
  }

  static Future<void> updateCollection(
    String collection,
    String id,
    Map<String, dynamic> newItem,
  ) async {
    final db = await _readDatabase();
    final List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(
      db[collection] ?? [],
    );
    final index = items.indexWhere((item) => item['id'] == id);

    if (index != -1) {
      items[index] = newItem;
      db[collection] = items;
      await _writeDatabase(db);
    }
  }

  static Future<void> deleteFromCollection(String collection, String id) async {
    final db = await _readDatabase();
    db[collection] =
        (db[collection] as List).where((item) => item['id'] != id).toList();
    await _writeDatabase(db);
  }
}
