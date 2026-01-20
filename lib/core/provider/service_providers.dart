import 'package:notescan/core/services/image_picker_service.dart';
import 'package:notescan/core/services/text_recognition_service.dart';
import 'package:riverpod/riverpod.dart';

final imagePickerServiceProvider =
    Provider((ref) => ImagePickerService());

final ocrServiceProvider =
    Provider((ref) => OcrService());
