import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ocr/features/text_scanner/providers/text_scanner_provider.dart';
import 'package:ocr/features/text_scanner/view/camera_view.dart';
import 'package:ocr/features/text_scanner/view/result_view.dart';

class CaptureView extends ConsumerWidget {
  const CaptureView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(textScannerProvider);

    ref.listen(textScannerProvider, (previous, next) {
      if ((previous?.text ?? '').isEmpty && next.text.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultView(text: next.text),
          ),
        ).then((_) {
          ref.read(textScannerProvider.notifier).reset();
        });
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('OCR'), centerTitle: true),
      body: Center(
        child: state.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final imagePath = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CameraView(),
                        ),
                      );

                      if (imagePath != null) {
                        ref
                            .read(textScannerProvider.notifier)
                            .scanFromPath(imagePath);
                      }
                    },
                    child: const Text('Capture Image'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(textScannerProvider.notifier)
                        .scanText(source: ImageSource.gallery),
                    child: const Text('Pick from Gallery'),
                  ),
                ],
              ),
      ),
    );
  }
}
