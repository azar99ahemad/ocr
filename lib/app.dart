 import 'package:flutter/material.dart';
import 'package:notescan/features/text_scanner/view/capture_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CaptureView(),
    );
  }
}

