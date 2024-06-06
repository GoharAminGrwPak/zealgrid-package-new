import 'dart:nativewrappers/_internal/vm/lib/mirrors_patch.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Zealgrid {
  final String path;
  final Map<String, dynamic> _data = {};

  Zealgrid._({this.path = ''});

  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  static Future<Zealgrid> getInstance({String path = ''}) async {
    Zealgrid instance = Zealgrid._(path: path);
    await instance._fetchData();
    return instance;
  }

  Future<void> _fetchData() async {
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

  dynamic _getProperty(String propertyName) {
    List<String> properties = propertyName.split('.');
    dynamic currentData = _data;

    for (String property in properties) {
      if (currentData is Map<String, dynamic> && currentData.containsKey(property)) {
        currentData = currentData[property];
      } else {
        throw Exception('Property not found: $propertyName');
      }
    }

    return currentData;
  }

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      final propertyName = MirrorSystem.getName(invocation.memberName);
      return _getProperty(propertyName);
    }
    return super.noSuchMethod(invocation);
  }
}