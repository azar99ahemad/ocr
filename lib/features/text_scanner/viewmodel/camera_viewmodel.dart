import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraViewModel extends Notifier<CameraController?> {
  @override
  CameraController? build() {
    return null;
  }

  Future<void> initialize() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
    );

    final controller = CameraController(
      backCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller.initialize();
    state = controller;
  }

  Future<XFile?> capture() async {
    if (state == null || !state!.value.isInitialized) return null;

    final image = await state!.takePicture();

    await disposeCamera();
    return image;
  }

  Future<void> disposeCamera() async {
    await state?.dispose();
    state = null;
  }
}
