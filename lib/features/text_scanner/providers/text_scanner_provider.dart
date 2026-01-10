
import 'package:riverpod/riverpod.dart';

import 'package:ocr/features/text_scanner/viewmodel/text_scanner_state.dart';
import 'package:ocr/features/text_scanner/viewmodel/text_scanner_viewmodel.dart';

// text_scanner_provider.dart
final textScannerProvider =
    NotifierProvider<TextScannerViewModel, TextScannerState>(
  TextScannerViewModel.new,
);

