import 'package:riverpod/riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ocr/core/provider/service_providers.dart';
import 'package:ocr/core/services/image_picker_service.dart';
import 'package:ocr/core/services/text_recognition_service.dart';
import 'text_scanner_state.dart';

class TextScannerViewModel extends Notifier<TextScannerState> {
  late final ImagePickerService _imageService;
  late final OcrService _ocrService;

  @override
  TextScannerState build() {
    _imageService = ref.read(imagePickerServiceProvider);
    _ocrService = ref.read(ocrServiceProvider);
    return const TextScannerState();
  }

  Future<void> scanText({required ImageSource source}) async {
    state = state.copyWith(isLoading: true);

    final image = source == ImageSource.camera
        ? await _imageService.captureFromCamera()
        : await _imageService.pickFromGallery();

    if (image == null) {
      state = state.copyWith(isLoading: false);
      return;
    }

    final text = await _ocrService.extractText(image.path);

    state = state.copyWith(
      isLoading: false,
      text: text,
    );
  }

  Future<void> scanFromPath(String path) async {
  state = state.copyWith(isLoading: true);

  final text = await _ocrService.extractText(path);

  state = state.copyWith(
    isLoading: false,
    text: text,
  );
}



  void reset() {
    state = const TextScannerState();
  }
}
