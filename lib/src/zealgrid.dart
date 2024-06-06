import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Zealgrid {
  final String path;
  final Map<String, dynamic> _data = {};

  Zealgrid._({this.path = ''});

  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  static Zealgrid getInstance({String path = ''}) {
    return Zealgrid._(path: path);
  }

  Zealgrid operator [](String key) {
    return Zealgrid._(path: '$path/$key');
  }

  Future<void> _fetchData() async {
    if (_data.isEmpty) {
      try {
        DataSnapshot snapshot = await _database.child(path).get();
        if (snapshot.value != null && snapshot.value is Map) {
          _data.addAll(Map<String, dynamic>.from(snapshot.value as Map));
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching data: $e');
        }
      }
    }
  }

  Future<T?> _getValue<T>(String key) async {
    await _fetchData();
    return _data[key] as T?;
  }

  Future<String?> getString(String key) async => await _getValue<String>(key);
  Future<int?> getInt(String key) async => await _getValue<int>(key);
  Future<bool?> getBool(String key) async => await _getValue<bool>(key);
  Future<Map<String, dynamic>?> getObject(String key) async => await _getValue<Map<String, dynamic>>(key);
  Future<List<dynamic>?> getList(String key) async => await _getValue<List<dynamic>>(key);

  Future<dynamic> getValue(String key) async => await _getValue(key);
}