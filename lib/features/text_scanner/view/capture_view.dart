import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ocr/features/text_scanner/providers/text_scanner_provider.dart';
import 'package:ocr/features/text_scanner/view/camera_view.dart';
import 'package:ocr/features/text_scanner/view/result_view.dart';
import 'package:ocr/features/text_scanner/viewmodel/text_scanner_state.dart';
import 'package:ocr/shared/widgets/primary_button.dart';

class CaptureView extends ConsumerWidget {
  const CaptureView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(textScannerProvider);

    // ref.listen(textScannerProvider, (previous, next) {
    //   if ((previous?.text ?? '').isEmpty && next.text.isNotEmpty) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (_) => ResultView(text: next.text),
    //       ),
    //     ).then((_) {
    //       ref.read(textScannerProvider.notifier).reset();
    //     });
    //   }
    // });

    ref.listen<TextScannerState>(textScannerProvider, (previous, next) {
      final prevText = previous?.text ?? '';
      final nextText = next.text;

      if (prevText.isEmpty && nextText.isNotEmpty) {
        showModalBottomSheet(
          // useSafeArea: false,
          // // enableDrag: true,

          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ResultView(text: nextText),
        ).then((_) {
          // ✅ reset only after sheet is closed
          ref.read(textScannerProvider.notifier).reset();
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5E6),
      appBar: AppBar(
        title: const Text(
          'OCR ',
          style: TextStyle(
            color: Color(0xFF6E7454),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF3F5E6),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // -------- Empty State --------
            Expanded(
              child: Center(
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Color(0xFF6E7454),)
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.description_outlined,
                            size: 64,
                            color: Color(0xFFB9C28F),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No scans Yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Tap the camera button below to scan your first\nhandwritten note',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // -------- Bottom Buttons --------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  PrimaryButton(
                    label: 'Scan Text',
                    icon: Icons.camera_alt,
                    onTap: () async {
                      final imagePath = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(builder: (_) => const CameraView()),
                      );

                      if (imagePath != null) {
                        ref
                            .read(textScannerProvider.notifier)
                            .scanFromPath(imagePath);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'Upload from gallery',
                    icon: Icons.download,
                    filled: false,
                    onTap: () {
                      ref
                          .read(textScannerProvider.notifier)
                          .scanText(source: ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
