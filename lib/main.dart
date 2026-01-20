import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ocr/shared/storage/scan_storage.dart';

import 'app.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); 
   await Hive.initFlutter();
  await Hive.openBox<String>('scans');
ScanStorage.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
