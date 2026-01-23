import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notescan/shared/storage/scan_storage.dart';

import 'app.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); 
   await Hive.initFlutter();
   // Delete old box (only if type mismatch)
  if (Hive.isBoxOpen('scans')) {
    await Hive.box('scans').close();
  }
  await Hive.deleteBoxFromDisk('scans');
  ScanStorage.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
