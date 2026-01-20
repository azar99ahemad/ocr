import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ocr/features/text_scanner/providers/text_scanner_provider.dart';
import 'package:ocr/features/text_scanner/view/camera_view.dart';
import 'package:ocr/features/text_scanner/view/result_view.dart';
import 'package:ocr/features/text_scanner/viewmodel/text_scanner_state.dart';
import 'package:ocr/shared/storage/scan_storage.dart';
import 'package:ocr/shared/widgets/emptyState.dart';
import 'package:ocr/shared/widgets/primary_button.dart';
import 'package:ocr/shared/widgets/scanList.dart';

class CaptureView extends ConsumerStatefulWidget {
  const CaptureView({super.key});

  @override
  ConsumerState<CaptureView> createState() => _CaptureViewState();
}

class _CaptureViewState extends ConsumerState<CaptureView> {
  bool _fabOpen = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(textScannerProvider);
    // final scans = ScanStorage.getAll();


    ref.listen<TextScannerState>(textScannerProvider, (previous, next) {
      final prevText = previous?.text ?? '';
      final nextText = next.text;

      if (prevText.isEmpty && nextText.isNotEmpty) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ResultView(text: nextText, index: null,),
        ).then((_) {
          ref.read(textScannerProvider.notifier).reset();
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5E6),
      appBar: AppBar(
        title: const Text(
          'OCR',
          style: TextStyle(
            color: Color(0xFF6E7454),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF3F5E6),
      ),
      body: SafeArea(
  child: Stack(
    children: [
      /// -------- Main Content --------
      if (state.isLoading)
        const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF6E7454),
          ),
        )
      else ValueListenableBuilder<List<String>>(
  valueListenable: ScanStorage.scans,
  builder: (context, scans, _) {
    if (scans.isEmpty) return EmptyState();
    return ScanList(scans: scans);
  },
),


      /// -------- FAB Menu --------
      Positioned(
        bottom: 24,
        right: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 260,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _fabOpen
                    ? Column(
                        key: const ValueKey('menu'),
                        children: [
                          PrimaryButton(
                            label: 'Scan Text',
                            icon: Icons.camera_alt,
                            onTap: () async {
                              setState(() => _fabOpen = false);

                              final imagePath =
                                  await Navigator.push<String>(
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
                          ),
                          const SizedBox(height: 12),
                          PrimaryButton(
                            label: 'Upload from gallery',
                            icon: Icons.download,
                            onTap: () {
                              setState(() => _fabOpen = false);
                              ref
                                  .read(textScannerProvider.notifier)
                                  .scanText(
                                    source: ImageSource.gallery,
                                  );
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      )
                    : const SizedBox(
                        key: ValueKey('empty'),
                        height: 0,
                      ),
              ),
            ),

            FloatingActionButton(
              backgroundColor: const Color(0xFFBFC89A),
              elevation: 0,
              onPressed: () {
                setState(() => _fabOpen = !_fabOpen);
              },
              child: AnimatedRotation(
                turns: _fabOpen ? 0.125 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.add, color: Colors.black),
              ),
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
