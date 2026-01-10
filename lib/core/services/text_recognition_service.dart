import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService{
  Future<String> extractText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final recognizer = TextRecognizer();
    final result = await recognizer.processImage(inputImage);
    await recognizer.close();
    return result.text;
  }
}
