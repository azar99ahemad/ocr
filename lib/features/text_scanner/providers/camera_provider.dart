import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/camera_viewmodel.dart';

final cameraProvider =
    NotifierProvider<CameraViewModel, CameraController?>(
  CameraViewModel.new,
);
