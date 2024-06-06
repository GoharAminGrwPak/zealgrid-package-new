import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Zealgrid {
  final String path;

  Zealgrid._({this.path = ''});

  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  static final Map<String, Zealgrid> _instances = {};

  static Zealgrid getInstance({String path = ''}) {
    if (_instances.containsKey(path)) {
      return _instances[path]!;
    } else {
      Zealgrid instance = Zealgrid._(path: path);
      _instances[path] = instance;
      return instance;
    }
  }

  Zealgrid child(String child) {
    return Zealgrid._(path: '$path/$child');
  }

  Future<String?> getString(String key) async {
    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
      if (snapshot.value != null) {
        return snapshot.value.toString();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<int?> getInt(String key) async {
    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
      if (snapshot.value != null) {
        return int.tryParse('${snapshot.value}');
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<bool?> getBool(String key) async {
    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
      if (snapshot.value != null) {
        return bool.tryParse('${snapshot.value}');
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getObject(String key) async {
    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
      if (snapshot.value != null && snapshot.value is Map) {
        Map<String, dynamic> jsonData = {};
        (snapshot.value as Map).forEach((key, value) {
          jsonData['$key'] = value;
        });
        return jsonData;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getList(String key) async {
    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
      if (snapshot.value != null && snapshot.value is List) {
        List<Map<String, dynamic>> resultList = [];
        for (var ele in (snapshot.value as List)) {
          Map<String, dynamic> jsonData = {};
          Map dataMap = ele as Map;
          dataMap.forEach((key, value) {
            jsonData['$key'] = value;
          });
          resultList.add(jsonData);
        }
        debugPrint('runtimeType Step3 ${resultList.length}');
        return resultList;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return [];
    }
  }
}
