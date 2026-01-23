import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

class ScanStorage {
  static const _boxName = 'scans';
  static final _uuid = Uuid();

    // ValueNotifier to update UI when scans change
  static final ValueNotifier<List<Map<String, String>>> scans =
      ValueNotifier([]);

  // Safe typed box
  static Box<Map<String, String>> get _box => Hive.box<Map<String, String>>(_boxName);

  /// Initialize Hive box and load existing scans
  static Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<Map<String, String>>(_boxName);
    }

    // Load existing scans
    scans.value = _box.values.map((e) => Map<String, String>.from(e)).toList();

    // Optional: listen to box changes automatically
    _box.listenable().addListener(() {
      scans.value = _box.values.map((e) => Map<String, String>.from(e)).toList();
    });
  }

  /// Save scan and RETURN id ✅
  static String save(String text) {
    final id = _uuid.v4();

    _box.add({'id': id, 'text': text});

    // Update notifier
    scans.value = _box.values.map((e) => Map<String, String>.from(e)).toList();

    return id;
  }

  static String getIdAt(int index) => scans.value[index]['id']!;
  static String getTextAt(int index) => scans.value[index]['text']!;

  static void deleteAt(int index) {
    _box.deleteAt(index);
    scans.value = _box.values.map((e) => Map<String, String>.from(e)).toList();
  }
}



