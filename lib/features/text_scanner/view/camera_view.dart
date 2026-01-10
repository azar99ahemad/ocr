import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:ocr/features/text_scanner/viewmodel/camera_viewmodel.dart';

import '../providers/camera_provider.dart';

class CameraView extends ConsumerStatefulWidget {
  const CameraView({super.key});

  @override
  ConsumerState<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView> {
  late final CameraViewModel _cameraVM;

  @override
  void initState() {
    super.initState();
    debugPrint('Camera initialized');


    // ✅ Cache notifier ONCE (safe)
    _cameraVM = ref.read(cameraProvider.notifier);
    debugPrint('Camera initialized2');


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cameraVM.initialize();
    });
    debugPrint('Camera initialized3');

  }

  @override
  void dispose() {
    // ✅ SAFE: no ref usage here
    _cameraVM.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(cameraProvider);

    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(controller),

          // Dark overlay
          Container(color: Colors.black.withOpacity(0.4)),

          // Transparent scan frame
          Center(
            child: Container(
              width: 280,
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),

          // Instruction
          const Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Text(
              'Position your notes within the frame',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),

          // Capture button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final image = await _cameraVM.capture();
                  if (image == null) return;

                  Navigator.pop(context, image.path);
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
