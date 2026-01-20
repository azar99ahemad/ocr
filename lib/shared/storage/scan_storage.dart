import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ScanStorage {
  static const _boxName = 'scans';
  static final ValueNotifier<List<String>> scans =
      ValueNotifier<List<String>>([]);

  static Box<String> get _box => Hive.box<String>(_boxName);

  /// Call this once at app start
  static void init() {
    scans.value = _box.values.toList();
  }

  static void save(String text) {
    _box.add(text);
    scans.value = _box.values.toList();
  }

  static void deleteAt(int index) {
    _box.deleteAt(index);
    scans.value = _box.values.toList();
  }
}


