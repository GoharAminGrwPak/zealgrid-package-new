
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Zealgrid {
  static Zealgrid? _this;
  final String path;

  Zealgrid._({this.path = ''});

  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  static Zealgrid getInstance({String path = ''}) {
    _this ??= Zealgrid._(path: path);
    return _this!;
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
        return null; // Return null if the key doesn't exist or has no value
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of any error
    }
  }

  Future<int?> getInt(String key) async {

    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
      if (snapshot.value != null) {
        return int.tryParse('${snapshot.value}');
      } else {
        return null; // Return null if the key doesn't exist or has no value
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of any error
    }
  }

  Future<bool?> getBool(String key) async {

    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
      if (snapshot.value != null) {
        return bool.tryParse('${snapshot.value}');
      } else {
        return null; // Return null if the key doesn't exist or has no value
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of any error
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
        return  jsonData;
      }

      return null; // Return null if the key doesn't exist or has no value
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null; // Return null in case of any error
    }
  }

  Future<List<Map<String, dynamic>>> getList(String key) async {
    try {

      DataSnapshot snapshot = await _database.child(path).child(key).get();

      if (snapshot.value != null && snapshot.value is List) {

        // Convert dataMap to Map<String, dynamic>
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
      return []; // Return an empty list in case of any error
    }
  }
}